Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313113AbSDEQ60>; Fri, 5 Apr 2002 11:58:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313131AbSDEQ6Q>; Fri, 5 Apr 2002 11:58:16 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:27615 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S313113AbSDEQ6D>; Fri, 5 Apr 2002 11:58:03 -0500
Message-ID: <3CADD798.20203@us.ibm.com>
Date: Fri, 05 Apr 2002 08:58:00 -0800
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: roms@lpg.ticalc.org, linux-kernel@vger.kernel.org
Subject: Re: BKL in tiglusb release function
In-Reply-To: <3CACF1FF.2000508@us.ibm.com> <3CAD74DA.58561BF7@free.fr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Romain Liévin wrote:
 > I have followed examples from other codes such as dabusb.c &
 > printer.c (2.4.14). After a further look: - dabusb.c from 2.4.14
 > contains a kernel_lock/unlock couple only in _release but it has
 > been removed in 2.5.7 - printer.c contains a kernel_lock/unlock
 > couple in _open & _release in both 2.4.14 and 2.5.7

I was probably responsible for the removal from dabusb.c.  In almost all
cases that I found (over 60 of them), the BKL is not needed in the 
release function.

The use of s->mutex confuses me.  In tiglusb_disconnect(), there is an 
up().  Where is the matching down?  The comment for the mutex just says, 
"locks this struct".  However, it is clear that it doesn't protect the 
whole structure.  There are many places where structure members are 
accessed without the lock being held.

-- 
Dave Hansen
haveblue@us.ibm.com

