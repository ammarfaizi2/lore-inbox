Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751138AbVH2VXH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751138AbVH2VXH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 17:23:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751142AbVH2VXH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 17:23:07 -0400
Received: from rproxy.gmail.com ([64.233.170.195]:21553 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751138AbVH2VXG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 17:23:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        b=AtcH2CKK6xj8hJrNQgVbH/pAOyv/Y0Wcq24nkKYUvjZmnJC2NNVlVjEBmsFkHDKHi39KP5SpBqWypvTUIF0q2ktvqqm30CYpqd4gs6mBXjANPvl190H8TFpaia5Rc5BTpPC5SOuRcOJV1WcCnRNF/bX5qYDvOM/Xgq/wfry5jPw=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 0/3] remove verify_area()
Date: Mon, 29 Aug 2005 23:23:59 +0200
User-Agent: KMail/1.8.2
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>,
       Chris Zankel <zankel@tensilica.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200508292324.01342.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, 
	it's time to kill off verify_area().

	verify_area() has been deprecated for quite a while now and is 
documented in Documentation/feature-removal-schedule.txt as going away in 
July 2005.
It is completely replaced by access_ok() and there are no in-kernel users
left [1]. It's time for verify_area() to die.

	The following 3 patches remove verify_area() itself as well as 
remove or modify some documentation related to it.


 1 - remove verify_area() from various uaccess.h headers
 2 - remove or edit references to verify_area in Documentation/
 3 - remove fs/umsdos/notes as it only contain a verify_area related note

 note: I only have access to i386 hardware, so that's all I've been able to
       test on, but since there are no users of this left and the patch just
       remove the unused function, there should really not be any trouble.


[1] The Xtensa architecture was merged post the big verify_area() to 
    access_ok() cleanup I did some months back and is still using 
    verify_area(). I've submitted sepperate cleanup patches to get rid of 
    it from Xtensa to Chris Zankel and they should flow your way eventually.
    These 3 patches therefore leave Xtensa alone.


-- 
 Jesper Juhl

