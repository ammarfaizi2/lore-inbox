Return-Path: <linux-kernel-owner+w=401wt.eu-S965252AbXATKYD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965252AbXATKYD (ORCPT <rfc822;w@1wt.eu>);
	Sat, 20 Jan 2007 05:24:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965251AbXATKYD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Jan 2007 05:24:03 -0500
Received: from wx-out-0506.google.com ([66.249.82.225]:11377 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965246AbXATKYB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Jan 2007 05:24:01 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=KSzVUB+iUh5tddLPjtmkkxjD/wm9zq2ntAgWfcvmhj740FcpfdaWrueEOpthjvlEg8dCfqbae6K0/CxXJxEYX0TwpCtNTANkcpD/nu4q2XCjgjBhLXwOKfKBDfHKMNL+x3Kd3Zb9nYWe17ZY3w617OzrxQJ8OSKCU5h6bKpPRaE=
Message-ID: <e92e3a770701200224n42c948d5oe75aa5eb907e9786@mail.gmail.com>
Date: Sat, 20 Jan 2007 15:54:00 +0530
From: "kalash nainwal" <nirvana.code@gmail.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: wake_up() takes long time to return
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

We've a kernel (n/w) module, which sits over ethernet. Whenever a pkt
is received (in softirq), after doing some minimal processing,
wake_up() is called to wake up another kernel thread which does rest
(bulk) of the processing.

We notice that this wake_up() call is sometimes taking as long as 48
milli-seconds to return. This happens around 10 times out of 10M. We
earlier thought its possibly because of the contention on rq->lock,
but we see the same phenomenon even on a uniprocessor box. So obviosly
thats not the case.

We can't figure out any other reason for wake_up() to take this much
time? As this call comes directly in our (receive) hotpath, we're very
concerned. Any help would be greatly appreciated.

Thanks and regards,
-Kalash
