Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268922AbTCARdE>; Sat, 1 Mar 2003 12:33:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268934AbTCARdE>; Sat, 1 Mar 2003 12:33:04 -0500
Received: from air-2.osdl.org ([65.172.181.6]:10686 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S268922AbTCARdD>;
	Sat, 1 Mar 2003 12:33:03 -0500
Message-ID: <1155.4.64.238.61.1046540568.squirrel@www.osdl.org>
Date: Sat, 1 Mar 2003 09:42:48 -0800 (PST)
Subject: Re: [Linux-NTFS-Dev] [PATCH] reduce large stack usage
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: <clausen@gnu.org>
In-Reply-To: <20030301094454.GA1058@gnu.org>
References: <3E605BEF.89DB801F@verizon.net>
        <20030301094454.GA1058@gnu.org>
X-Priority: 3
Importance: Normal
Cc: <aia21@cantab.net>, <linux-kernel@vger.kernel.org>,
       <linux-ntfs-dev@lists.sourceforge.net>
X-Mailer: SquirrelMail (version 1.2.8)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi Randy,
>
> On Fri, Feb 28, 2003 at 11:06:23PM -0800, Randy.Dunlap wrote:
>> This patch to 2.5.63 reduces stack usage in generate_default_upcase() from
>> 0x3d4 bytes to just noise (on x86).
>>
>> The arrays are static so they are still private (hidden), but
>> now they aren't allocated on the stack and copied there for
>> temp use.
>
> BTW, you can declare "local" variables inside a function as static, which
> makes them "global", but locally scoped.  The code should be basically
> equivalent, but perhaps more elegant...
>
> i.e.:
>
>  uchar_t *generate_default_upcase(void)
>  {
> -	const int uc_run_table[][3] = { /* Start, End, Add */
> +static const int uc_run_table[][3] = { /* Start, End, Add */
>  	{0x0061, 0x007B,  -32}, {0x0451, 0x045D, -80}, {0x1F70, 0x1F72,  74},
> {0x00E0, 0x00F7,  -32}, {0x045E, 0x0460, -80}, {0x1F72, 0x1F76,  86},
> {0x00F8, 0x00FF,  -32}, {0x0561, 0x0587, -48}, {0x1F76, 0x1F78, 100},
>
> Cheers,
> Andrew

Yes, of course.  I'll remake the patch unless someone else does.
(-ESLEEPY last night)

Thanks,
~Randy




