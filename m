Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315286AbSDWR7q>; Tue, 23 Apr 2002 13:59:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315289AbSDWR7p>; Tue, 23 Apr 2002 13:59:45 -0400
Received: from mg03.austin.ibm.com ([192.35.232.20]:31174 "EHLO
	mg03.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S315286AbSDWR7o>; Tue, 23 Apr 2002 13:59:44 -0400
Message-ID: <3CC59F98.C82E694B@austin.ibm.com>
Date: Tue, 23 Apr 2002 12:53:28 -0500
From: James L Peterson <peterson@austin.ibm.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9-31 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: paulus@samba.org
CC: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: PowerPC Linux and PCI
In-Reply-To: <OF8A238806.80D1511C-ON87256B75.00773B75@boulder.ibm.com>
		<20020307220318.GA4664@haven>
		<3CC08DFF.787F6E54@austin.ibm.com>
		<20020419.143839.15920500.davem@redhat.com>
		<15553.12447.849592.261245@argo.ozlabs.ibm.com>
		<3CC41AC6.BD8E32E4@austin.ibm.com> <15557.5295.921549.964163@argo.ozlabs.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Mackerras wrote:

> > Little-endian dword:
> >
> >           3    2      1    0
> >          80  86    71 11
>
> So we have byte[0] = 0x11, byte[1] = 0x71, byte[2] = 86, byte[3] =
> 0x80, right?  If we read individual bytes we will get the same results
> on a little-endian or a big-endian platform.
>
> On a little endian platform, pci_read_config_dword will return
> 0x80867111, since byte 0 is the least-significant byte.  Thus we have
> vendor id = 0x7111 and device-id = 0x8086.
>
> On a big-endian platform a 32-bit read will return 0x11718680 (since
> byte 0 is the most significant byte), and pci_read_config_dword will
> byte-swap that to 0x80867111.  Thus we once again have vendor id =
> 0x7111 and device-id = 0x8086.
>

Actually, in our case, the first dword was 0x80867111 (little-endian),
so when we read the first dword, we got 0x80867111 (big-endian),
since we were reading a dword, not individual bytes. If we read the
individual bytes, we do get the right bytes, but the PCI subsystem
returns the same bytes to us for either a little-endian or big-endian
dword read, since it doesn't know if the processor is big-endian
or little-endian  (The PowerPC can be both, or different processors
on the same bus can be different at the same time).


> Doesn't the fact that people have been successfully using PCI devices
> in PowerPC machines since 1995 or 1996 suggest to you that it might be
> your understanding that is faulty rather than the code? :)

Well, when you have new hardware, a new compiler (with known bugs),
and a new processor chip, the fact that it works for others doesn't mean
that it's right.  It hardly seems wise to assume there are no problems
left
in the software.  My original question was "How can this work (since it
clearly must be working) when it does not appear to be correct?"
It's not as if the code is clearly documented that it depends upon the
PCI hardware knowing if it should return big-endian or little-endian
data.

jim



