Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933251AbWFZWit@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933251AbWFZWit (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 18:38:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933254AbWFZWit
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:38:49 -0400
Received: from nz-out-0102.google.com ([64.233.162.197]:34055 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S933251AbWFZWir (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:38:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=YN/eA+9qC2z1Kj4C5I0rgq0wAY/BSqjptwL4h2y4QJUWoHGuTV4+hklSLuYM5wHG4rrHtIKRzdPqIg1OQO8Sm1RxoZ9cvHErieum2cTRumkNXwtPlq6Qi/FHRS/7EA+nU1Kyje7JF+kN7fGDkmzRlm/bwddNsMafhJFyAOadvx8=
Message-ID: <9e4733910606261538i584e2203o9555d77094de6fe7@mail.gmail.com>
Date: Mon, 26 Jun 2006 18:38:46 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: tty_mutex and tty_old_pgrp
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In tty_io.c there is a comment that tty_mutex needs to be held before
changing tty_old_pgrp. If I grep for tty_old_pgrp every place it is
changed except for one is protected by tty_mutex.
In security/selinux/hooks.c it appears to be changed without holding
the lock, is this ok? If it is ok, I can add a comment saying it is.

If someone were to provide me with the proper guidance, I have some
time I could spend working on the tty code. For example from an object
oriented perspective it doesn't look right to me that
disassociate_ctty is a function in the tty layer. It makes more sense
to me that this function would be located in the task code.

How could things be rearranged to avoid the need for sys_setsid() and
daemonize() to directly manipulate tty_mutex? What exactly is
tty_mutex protecting, it appears to be used in multiple contexts.

-- 
Jon Smirl
jonsmirl@gmail.com
