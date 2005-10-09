Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932253AbVJITZb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932253AbVJITZb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Oct 2005 15:25:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750913AbVJITZb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Oct 2005 15:25:31 -0400
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36]:43936 "HELO
	smtp005.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1750783AbVJITZa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Oct 2005 15:25:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=aNhaGvCs+exGEWTv2Tg7XvS2Fn3GbqL40pdlkN2qOFmXsbDoDKSdmTrSgaK4QrFysKSWWLlejrrVr/mrVjvEaFoHtORhwYC8VIqvdMazlv/Ec9VnkdhVKAjy4b+djtw922TJQDdvfc8DW90Pd29oqRmtCFs0ikUpLjTMfFhsABk=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: Junichi Uekawa <dancer@netfort.gr.jp>
Subject: Re: [PATCH] UML TT-mode-only compile fix.
Date: Sun, 9 Oct 2005 21:26:04 +0200
User-Agent: KMail/1.8.2
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <87psqf2s9p.dancerj%dancer@netfort.gr.jp>
In-Reply-To: <87psqf2s9p.dancerj%dancer@netfort.gr.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510092126.04881.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 09 October 2005 07:06, Junichi Uekawa wrote:
> Hi,
>
> In today's linus's git tree, uml doesn't compile when it's configured for
> only TT-mode.

> This regression caused by:
> 	8923648c125421b0fcb240cde607e2748d099ab8
> 	[PATCH] uml: clear SKAS0/3 flags when running in TT mode
>
> Signed-off-by: Junichi Uekawa <dancer@debian.org>
Thanks for the report and the patch, however I want to fix things a bit 
differently... the thing _should_ compile anyway.

The macro is declared anyway and the var should exist anyway.
The problem is just that they aren't declared, I think. Will fix.

> diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
> --- a/arch/um/kernel/um_arch.c
> +++ b/arch/um/kernel/um_arch.c
> @@ -334,8 +334,10 @@ int linux_main(int argc, char **argv)
>  		add_arg(DEFAULT_COMMAND_LINE);
>
>  	os_early_checks();
> +#ifdef CONFIG_MODE_SKAS
>  	if (force_tt)
>  		clear_can_do_skas();
> +#endif
>  	mode_tt = force_tt ? 1 : !can_do_skas();
>  #ifndef CONFIG_MODE_TT
>  	if (mode_tt) {

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
