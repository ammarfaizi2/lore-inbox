Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279976AbRKIQXI>; Fri, 9 Nov 2001 11:23:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279980AbRKIQWs>; Fri, 9 Nov 2001 11:22:48 -0500
Received: from fandango.cs.unitn.it ([193.205.199.228]:37638 "EHLO
	fandango.cs.unitn.it") by vger.kernel.org with ESMTP
	id <S279976AbRKIQWi> convert rfc822-to-8bit; Fri, 9 Nov 2001 11:22:38 -0500
From: Massimo Dal Zotto <dz@cs.unitn.it>
Message-Id: <200111091622.RAA18483@fandango.cs.unitn.it>
Subject: Re: [PATCH] SMM BIOS on Dell i8100
In-Reply-To: <20011109133453.A8130@emeraude.kwisatz.net> from Stephane Jourdois
	at "Nov 9, 2001 01:34:53 pm"
To: stephane@tuxfinder.org
Date: Fri, 9 Nov 2001 15:57:08 +0100 (MET)
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Thu, Nov 08, 2001 at 07:14:03PM +0100, Massimo Dal Zotto wrote:
> > I have released version 1.4 of my package with a new kernel module and
> > some enhancements to the i8kmon utility.
> 
> hello,
> 
> [no patch today :-)]
> 
> here is what top gives me :
>   PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
>  8102 kwisatz   15   0  2612 2612  1804 S     1.3  0.5   0:01 tclsh
>  1663 kwisatz   10   0  3172 2436  2028 S     0.1  0.4   0:25 gkrellm
> 
> It seems that gkrellm (which monitors more than 20 things on my laptop)
> takes only 0.1% of cpu, whereas i8kmon takes 1.3%...
> I have absolutely no idea how to improve that, but I think that should
> be the first thing on the TODO :-)
> 

Hi Stephane,

first question, why is your mailer using a charset=unknown-8bit instead
of the standard iso8859-1?

> Content-Type: text/plain; charset=unknown-8bit
> Content-Disposition: inline
> Content-Transfer-Encoding: quoted-printable

This gives an error in my editor elm and forces me to use cut-and-paste:

> [Charset unknown-8bit unsupported, skipping...]


Now back to i8kutils. No patch today because I was debugging exactly this
problem. I discovered that the SMM calls GET_CPU_TEMP and GET_POWER_STATUS
take a very long time compared to the other calls and this slows down the
whole program. Here is what I discovered:

    cpu_temp    = i8k_get_cpu_temp();			/* 11100 탎 */
    left_fan    = i8k_get_fan_status(I8K_FAN_LEFT);	/*   580 탎 */
    right_fan   = i8k_get_fan_status(I8K_FAN_RIGHT);	/*   580 탎 */
    left_speed  = i8k_get_fan_speed(I8K_FAN_LEFT);	/*   580 탎 */
    right_speed = i8k_get_fan_speed(I8K_FAN_RIGHT);	/*   580 탎 */
    ac_power    = i8k_get_power_status();		/* 14700 탎 */
    fn_key      = i8k_get_fn_status();			/*   750 탎 */

Since I can't fix the SMM BIOS I think there is very little I can do,
except avoiding the GET_POWER_STATUS call which uses half of the time.
I will try to get the same information from /proc/apm.

Did you try the latest version (1.4)? Does it work on your I8100?

-- 
Massimo Dal Zotto

+----------------------------------------------------------------------+
|  Massimo Dal Zotto               email: massimo.dalzotto@libero.it   |
|  Via Marconi, 141                phone: ++39-461534251               |
|  38057 Pergine Valsugana (TN)      www: http://www.cs.unitn.it/~dz/  |
|  Italy                                  http://www.debian.org/~dz/   |
|  gpg:   2DB65596  3CED BDC6 4F23 BEDA F489 2445 147F 1AEA 2DB6 5596  |
+----------------------------------------------------------------------+

