Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129458AbQK2Eux>; Tue, 28 Nov 2000 23:50:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129543AbQK2Eun>; Tue, 28 Nov 2000 23:50:43 -0500
Received: from sgi.SGI.COM ([192.48.153.1]:2111 "EHLO sgi.com")
        by vger.kernel.org with ESMTP id <S129458AbQK2Eul>;
        Tue, 28 Nov 2000 23:50:41 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Kurt Garloff <garloff@suse.de>
cc: Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.0-test: rmmod -a without effect
In-Reply-To: Your message of "Wed, 29 Nov 2000 01:37:22 BST."
             <20001129013721.C1777@garloff.etpnet.phys.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 29 Nov 2000 15:20:07 +1100
Message-ID: <8313.975471607@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2000 01:37:22 +0100,
Kurt Garloff <garloff@suse.de> wrote:
>this is a 2.4.0-test11 system;
>rmmod -a (modutils-2.3.21) fails to unload unused autocleanable modules:

Designed behaviour.  sys_delete_module only removes autoclean modules
that have been used at least once, either they have been used or some
other module has a reference to them.  Otherwise you get nasty races
like this

  cpu 0                           cpu 1
  request_module(foo)
    modprobe -k foo
      insmod -k foo
        foo is loaded, unused
  kernel sees foo has loaded
                                  rmmod -a
  kernel uses foo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
