Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136600AbREGShj>; Mon, 7 May 2001 14:37:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136601AbREGShU>; Mon, 7 May 2001 14:37:20 -0400
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:16901 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S136600AbREGShL>; Mon, 7 May 2001 14:37:11 -0400
Date: Mon, 7 May 2001 19:31:23 +0200
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: Bohdan Vlasyuk <Bohdan@kivc.vstu.vinnica.ua>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux + Compaq Presario Laptop
Message-ID: <20010507193123.F5208@arthur.ubicom.tudelft.nl>
In-Reply-To: <16736206722.20010507200652@kivc.vstu.vinnica.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <16736206722.20010507200652@kivc.vstu.vinnica.ua>; from Bohdan@kivc.vstu.vinnica.ua on Mon, May 07, 2001 at 08:06:52PM +0300
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 07, 2001 at 08:06:52PM +0300, Bohdan Vlasyuk wrote:
>   Hi !! I'm running linux on Compaq Presario 1215 Laptop. Kernel is,
> as shipped with RH 7.0, 2.2.16. So, every time I press any of
> sound<+-> buttons [of <Fn>+<Fx> {<Fn> = functional button, used in
> conjunction with F1-F8 to alter various laptop-specific settings, and
> to activate sleep mode, for example} ], linux crashes saying: "unable
> to handle kernel-paging request at virtual address 00005b18", and lot
> more (I can type it here, thought, I'm not sure if it's required, and
> it'll consume lots of time to type it precisely).

That's ACPI kicking in. The kernel you're using is quite old, and it
doesn't know about the BIOS e820 memory detection call. The kernel will
just use all memory, including memory that is also used by some ACPI
tables. When you press one of the magic buttons, the ACPI BIOS expects
the tables to be correct and jumps right into kernel code.

>   I guess it's not desired behavior as for stable system, and it
> should be fixed. I don't know if it's fixed already, just because
> today I have no means to transport 25M kernel to small laptop
> (moreover, there's no free space to compile kernel there), however,
> I'm going to solve it soon. I'm sorry if it's fixed already, or any
> stable and correct solution exists, and I'd be glad to hear about it.
> It not, I'd be glad to assist in investigating this problem.

Try linux-2.2.19, it contains BIOS e820 support. If you don't want to
compile a kernel, check if Red Hat has RPMs available somewhere on
their site. If you really can't use that, use the boot option "mem=<1MB
less than the machine actually has>" (so that's mem=127M for an 128MB
machine).


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
