Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129248AbQLDXUg>; Mon, 4 Dec 2000 18:20:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129257AbQLDXU0>; Mon, 4 Dec 2000 18:20:26 -0500
Received: from Cantor.suse.de ([194.112.123.193]:60174 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129248AbQLDXUQ>;
	Mon, 4 Dec 2000 18:20:16 -0500
Date: Mon, 4 Dec 2000 23:49:38 +0100
From: Andi Kleen <ak@suse.de>
To: "Boerner, Brian" <Brian_Boerner@adaptec.com>
Cc: "'linux-kernel@vger.redhat.com'" <linux-kernel@vger.kernel.org>
Subject: Re: aacraid for 2.4.0
Message-ID: <20001204234938.A26074@gruyere.muc.suse.de>
In-Reply-To: <E9EF680C48EAD311BDF400C04FA07B612D4D71@ntcexc02.ntc.adaptec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E9EF680C48EAD311BDF400C04FA07B612D4D71@ntcexc02.ntc.adaptec.com>; from Brian_Boerner@adaptec.com on Mon, Dec 04, 2000 at 05:31:04PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2000 at 05:31:04PM -0500, Boerner, Brian wrote:
> EIP:    0010:[<c881c054>]
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00010286
> eax: 00000025   ebx: c881c000   ecx: 00000000   edx: 00000000
  ^^^^^^^^^^^^^
> esi: 00000001   edi: 00000000   ebp: c88296a0   esp: c6b51e74
> ds: 0018   es: 0018   ss: 0018
> c0123180 
> Call Trace: [<c881c07e>] [<c8822c00>] [<c0120899>] [<c01a8bf8>] [<c88296a0>]
> [<c0123180>] [<c012345
> 1>] 
>        [<c881c000>] [<c881cb85>] [<c88296a0>] [<c88296a0>] [<c881c000>]
> [<c0118c65>] [<c881c060>] [
> <c0108f77>] 
> Code: 00 00 00 00 00 00 00 00 b8 00 00 00 83 ec 34 68 00 2c 82 c8 
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


> Code;  c881c054 <[aacraid]AAC_AnnounceDriver+0/8>   <=====
> 00000000 <_EIP>:   <=====
^^^^^^^^^^^^


It is jumping before the function AAC_DetectHostadapter, where there are 
0 bytes.  Two 0 bytes are "add %al,(%eax)" in x86. It is crashing 
because %eax does not contain a valid pointer (but 25). 

Now you just have to find out why you're jumping to the bogus pointer.
It could e.g. be caused by a stack overwrite.

Hope that helps,

-Andi


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
