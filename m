Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280633AbRKBKKK>; Fri, 2 Nov 2001 05:10:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280634AbRKBKKA>; Fri, 2 Nov 2001 05:10:00 -0500
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:59033 "EHLO pltn13.pbi.net")
	by vger.kernel.org with ESMTP id <S280633AbRKBKJt>;
	Fri, 2 Nov 2001 05:09:49 -0500
Date: Thu, 01 Nov 2001 22:16:19 -0800
From: Chris Rankin <rankinc@pacbell.net>
Subject: Re: on exit xterm  totally wrecks linux 2.4.11 to 2.4.14-pre6
 (unkillable processes)
To: thecrown@softhome.net
Cc: linux-kernel@vger.kernel.org
Message-id: <3BE23A33.7080001@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I see something similar with vanilla 2.4.13 (+devfs), except my 
unkillable xterms don't appear until a modprobe has already failed. 
Specifically, what seems to happen is:

- an open() call causes the kernel to grab the devfs rwsem for reading, 
and then load a module (e.g. ide-cd).
- the modprobe process then waits forever for write-access to the devfs 
rwsem.

Each xterm then waits forever in "wait_for_devfsd_finished()", 
presumably when it tries to close its terminal.

Are you also using dynamic module loading? Are ALL of your unkillable 
processes xterms, or do you also have a failed modprobe lurking somewhere?

Chris


