Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161108AbWF0Pc1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161108AbWF0Pc1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 11:32:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161109AbWF0Pc1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 11:32:27 -0400
Received: from terminus.zytor.com ([192.83.249.54]:44250 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1161108AbWF0Pc0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 11:32:26 -0400
Message-ID: <44A14F7B.2040600@zytor.com>
Date: Tue, 27 Jun 2006 08:32:11 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Ralf Baechle <ralf@linux-mips.org>
CC: klibc@zytor.com, linux-kernel@vger.kernel.org
Subject: Re: [klibc] [klibc 28/43] mips support for klibc
References: <klibc.200606251757.28@tazenda.hos.anvin.org> <20060626230345.GA14345@linux-mips.org>
In-Reply-To: <20060626230345.GA14345@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ralf Baechle wrote:
> On Sun, Jun 25, 2006 at 05:58:05PM -0700, H. Peter Anvin wrote:
> 
>> +typedef struct flock {
>> +	short	l_type;
>> +	short	l_whence;
>> +	loff_t	l_start;
>> +	loff_t	l_len;
>> +	pid_t	l_pid;
>> +} flock_t;
> 
> 32-bit MIPS uses this:
> 
> struct flock {
>         short   l_type;
>         short   l_whence;
>         off_t   l_start;
>         off_t   l_len;
>         long    l_sysid;
>         __kernel_pid_t l_pid;
>         long    pad[4];
> };

Does it use that for F_GETLK64 and friends?  klibc overrides the 
definitions so that F_GETLK is really F_GETLK64 etc; thus, "struct 
flock" in klibc userspace is really "struct flock64".  (To put it 
differently, klibc is always large-file compliant.)

As far as I can tell, MIPS uses the generic definition for struct 
flock64, which is the one I have above, so it should be correct.

	-hpa
