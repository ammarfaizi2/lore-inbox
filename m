Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262058AbTEEIKg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 04:10:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262063AbTEEIKg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 04:10:36 -0400
Received: from bunyip.cc.uq.edu.au ([130.102.2.1]:45071 "EHLO
	bunyip.cc.uq.edu.au") by vger.kernel.org with ESMTP id S262058AbTEEIKf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 04:10:35 -0400
Message-ID: <3EB62008.9000308@torque.net>
Date: Mon, 05 May 2003 18:25:44 +1000
From: Douglas Gilbert <dougg@torque.net>
Reply-To: dougg@torque.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: contrary ide_register() lock description 2.5.69
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The comments above ide_unregister() function definition
in lk 2.5.69 include this:

  *      Take care with the callbacks. These have been split to avoid
  *      deadlocking the IDE layer. The shutdown callback is called
  *      before we take the lock and free resources. It is up to the
  *      caller to be sure there is no pending I/O here, and that
  *      the interfce will not be reopened (present/vanishing locking
  *      isnt yet done btw). After we commit to the final kill we
  *      call the cleanup callback with the ide locks held.

The code that follows in ide.c shows the ide_lock
being taken prior to the shutdown callback and then
let go prior to cleanup callback. That's not what
those comments suggest.

However I do like the remaining comments in ide_unregister():

  *      Unregister restores the hwif structures to the default state.
  *      This is raving bonkers.

Doug Gilbert

