Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbQKPFCh>; Thu, 16 Nov 2000 00:02:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129186AbQKPFC2>; Thu, 16 Nov 2000 00:02:28 -0500
Received: from deliverator.sgi.com ([204.94.214.10]:24866 "EHLO
	deliverator.sgi.com") by vger.kernel.org with ESMTP
	id <S129183AbQKPFCU>; Thu, 16 Nov 2000 00:02:20 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Olaf Titz <olaf@bigred.inka.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: More modutils: It's probably worse. 
In-Reply-To: Your message of "Wed, 15 Nov 2000 11:43:54 BST."
             <E13w02k-000172-00@g212.hadiko.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 16 Nov 2000 15:31:35 +1100
Message-ID: <7639.974349095@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Nov 2000 11:43:54 +0100, 
>Why is there any reason that a shell should be invoked anywhere in the
>request_module->modprobe->insmod chain?
>If implemented correctly, this attack should have the same result as
>insmod ';chmod o+w .' (and it should not matter if it gets renamed so
>that the actual command executed is insmod 'netdevice-;chmod o+w .')

You are confusing two different problems.  The meta expansion problem
means ;chmod o+w .' does nasty things to your system.  The other
problem is that any user can load any module by ping6 -I module_name.

>> plus the
>> modprobe meta expansion algorithm.
>
>and I see no reason why modprobe should do any such thing, apart from
>configurations dealt with in modules.conf anyway.

modutils 2.3.20 only does meta expansion for entries in the config
file, not for input from the command line.  That fixes the first
problem but does nothing about the second.  The only way to fix the
second problem is by always adding a prefix to the user input before
passing it to modprobe, that fix has to be in the kernel, not modutils.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
