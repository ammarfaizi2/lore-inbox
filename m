Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272688AbTHEL7I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 07:59:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272689AbTHEL7I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 07:59:08 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:34067 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S272688AbTHEL7C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 07:59:02 -0400
Date: Tue, 5 Aug 2003 12:58:54 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: "Martin J. Bligh" <mbligh@aracnet.com>, hien1@us.ibm.com,
       sglass@us.ibm.com
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Bug 982] New: cu -l /dev/ttyS0 got a signal hangup in 2.5 kernel
Message-ID: <20030805125854.B30676@flint.arm.linux.org.uk>
Mail-Followup-To: "Martin J. Bligh" <mbligh@aracnet.com>, hien1@us.ibm.com,
	sglass@us.ibm.com, linux-kernel <linux-kernel@vger.kernel.org>
References: <3606320000.1059369234@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3606320000.1059369234@[10.10.2.4]>; from mbligh@aracnet.com on Sun, Jul 27, 2003 at 10:13:54PM -0700
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 27, 2003 at 10:13:54PM -0700, Martin J. Bligh wrote:
> Distribution: SuSE SLES8 
> Hardware Environment:NetVista 6579-A4U Pentium III - 866 MHz 256MB RAM 
> Software Environment:2.5.75 kernel 
> Problem Description: cu session fails to log into the other machine which is connected with a 
> null modem serial cable between serial ports. 
> It works fine in 2.4.19 4GB kernel 
>  
> Steps to reproduce: 
>   1. connecting two systems with a null modem serial cable between serial ports. 
>   2. On one machine, do : cu -l /dev/ttyS0 
>       On other system, have /sbin/agetty -L 9600 ttyS0 vt100  running. 
>       and ttyS0 has been defined in /etc/securetty 
>   3. cu session connected and showed you the login prompt. 
>   4. Got a hangup signal and disconnected after typing "root" or any user ID. 
>       It supposes to prompt you "password:" to let you type the password of the other machine 
>       to login to that system.

If I remember to update bugzilla...

What seems to be happening is that cu is clearing the "clocal" termios bit.
This means that when the CD line is dropped on ttyS0, cu receives a hangup
signal, as per the POSIX spec.  This seems reasonable.

There is a change of behaviour between 2.4 and 2.5 kernels though
(please confirm) - if you use the "callout" devices in 2.4, you don't
receive this hangup signal, even if the clocal bit is cleared.  Callout
devices no longer exist in 2.5.

The real question is this - why is the CD line being dropped between the
two machines between typing in the user name and asking for the password.

Maybe someone with this problem can give some details about the system
they're trying to log into rather than the local system.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

