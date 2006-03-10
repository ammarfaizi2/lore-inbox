Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752232AbWCJWcn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752232AbWCJWcn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 17:32:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752233AbWCJWcn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 17:32:43 -0500
Received: from smtp-out.google.com ([216.239.45.12]:15301 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1752230AbWCJWcn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 17:32:43 -0500
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:subject:content-type:content-transfer-encoding;
	b=kQlU88lHHP7l/041/ZroyP4bioZhvyRuCA0QhCJTFkv+ZglRcZyxiNOiYmnFQWbcO
	jkSXPYkpZVgd7X5WSgx6A==
Message-ID: <4411FE80.7030302@google.com>
Date: Fri, 10 Mar 2006 14:32:32 -0800
From: Daniel Phillips <phillips@google.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com
Subject: Another ocfs2 performance bug
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

Reading all the files in a big directory tree takes at least four times
as long on ocfs2 as ext3.

# ocfs2: Copy a kernel tree to /dev/null
mount -tocfs2 /dev/hdb /big
time find /big/linux-2.6.16-rc3 -type f -exec cp {} /dev/null \;

real   1m54.933s  <===
user   0m0.896s
sys    0m1.844s

time find /big/linux-2.6.16-rc3 -type f -exec cp {} /dev/null \;

real   0m14.301s
user   0m5.172s
sys    0m9.093s

# ext3: Copy a kernel tree to /dev/null
mount -text3 /dev/hdb /big
time find /big/linux-2.6.16-rc3 -type f -exec cp {} /dev/null \;

real    0m23.899s <===
user    0m4.672s
sys     0m9.513s

time find /big/linux-2.6.16-rc3 -type f -exec cp {} /dev/null \;

real    0m14.198s
user    0m5.168s
sys     0m8.977s

Regards,

Daniel
