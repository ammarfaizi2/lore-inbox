Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964909AbVIHQvn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964909AbVIHQvn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 12:51:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964911AbVIHQvn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 12:51:43 -0400
Received: from rproxy.gmail.com ([64.233.170.201]:49945 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964909AbVIHQvn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 12:51:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=up9cdxD1ni5KjXoNw3N0Chx5h8kPIfV6KB8cCRFgFKaquydweNOwzk+WncHT3dhLScMRFkNWuVdDXJxzkmDoCN5gGDnyUnnWU7j5Nb8pzu+aydWRDwAxn95j4T4ZQj/WdNgomHMo3S5va7g+kCuZOe+n+DD1hJ83fk+EqKC8/w8=
Message-ID: <d120d50005090809517daef043@mail.gmail.com>
Date: Thu, 8 Sep 2005 11:51:41 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Input: seeking internal API recommendation
Cc: linux-input@atrey.karlin.mff.cuni.cz, LKML <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vojtech,

I would like to lighten input_dev structure a bit and only allocate
memory for abs{val|min|max|flat|fuzz} for devices that are going to
generate absolute events. It will save 1260 bytes for every input
device registered.

If you remember I was also working on converting input devices to
sysfs (it progresses very nicely, I will post patches soon). As part
of that conversion I have a function input_allocate_device that
returns new input_dev structure. To ease error handling in individual
drivers I would like to have all memory allocation go into that
function. Plus we might switch other parts of input_dev to dynamic
allocation. So I see basically 2 possible options:

struct input_dev *input_allocate_device(int evbits); or
struct input_dev *input_allocate_device(int evbit,...)

The first form will not be sufficient if we ever go past 31 event
types, but I like it better than varargs.

Any suggestions?
-- 
Dmitry
