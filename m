Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262706AbTCJEGI>; Sun, 9 Mar 2003 23:06:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262708AbTCJEGI>; Sun, 9 Mar 2003 23:06:08 -0500
Received: from air-2.osdl.org ([65.172.181.6]:14803 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S262706AbTCJEGH>;
	Sun, 9 Mar 2003 23:06:07 -0500
Message-ID: <32835.4.64.238.61.1047269795.squirrel@www.osdl.org>
Date: Sun, 9 Mar 2003 20:16:35 -0800 (PST)
Subject: Re: [Linux-NTFS-Dev] ntfs OOPS (2.5.63)
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: <szaka@sienet.hu>
In-Reply-To: <Pine.LNX.4.30.0303081613070.2790-100000@divine.city.tvnet.hu>
References: <Pine.LNX.4.30.0303081100420.2790-100000@divine.city.tvnet.hu>
        <Pine.LNX.4.30.0303081613070.2790-100000@divine.city.tvnet.hu>
X-Priority: 3
Importance: Normal
Cc: <rddunlap@osdl.org>, <aia21@cantab.net>, <linux-kernel@vger.kernel.org>,
       <linux-ntfs-dev@lists.sourceforge.net>
X-Mailer: SquirrelMail (version 1.2.8)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> On Sat, 8 Mar 2003, Szakacsits Szabolcs wrote:
>>
>>  EFLAGS: 00010282
>>  eax: f6c0f080   ebx: 0000416d   ecx: 00010282 edx: f6c0f0f8
>>  esi: c040b078   edi: f6c0f0f8   ebp: f6dd1dbc esp: f6dd1db4
>>  ds: 007b   es: 007b   ss: 0068
>>
>>  3c0:       b9 06 00 00 00          mov    $0x6,%ecx
>>  ... not important ...
>>  3cc:       89 d7                   mov    %edx,%edi
>>  3ce:       89 55 f4                mov    %edx,0xfffffff4(%ebp) 3d1:
>>  f3 a5                   repz movsl %ds:(%esi),%es:(%edi) 3d3:       8d
>> 50 78                lea    0x78(%eax),%edx
>>  3d6:       8b 4d f4                mov    0xfffffff4(%ebp),%ecx 3d9:
>>  89 51 18                mov    %edx,0x18(%ecx)  ## OOPS ##
>>
>> So %ecx should be %edi-24 = f6c0f0e0, instead it's EFLAGS. Oops [indeed].
>> %ebp value is correct, I checked. So it seems a hardware, strong radiation
>> or an interrupt that didn't restore ecx.
>
> Actually the "interrupt" did a pushfl and overwrote 0xfffffff4(%ebp). esp =
> 0xfffffff4(%ebp). For kernel code the compiler shouldn't have generated the
> above code.
>
> 	Szaka

Hi Szaka,

Should I just close this bugzilla entry as invalid or not an NTFS problem?
I don't mind doing that.

Thanks,
~Randy



