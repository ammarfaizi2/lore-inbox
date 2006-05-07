Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932210AbWEGSAn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932210AbWEGSAn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 May 2006 14:00:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932213AbWEGSAn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 May 2006 14:00:43 -0400
Received: from smtp009.mail.ukl.yahoo.com ([217.12.11.63]:60590 "HELO
	smtp009.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S932210AbWEGSAm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 May 2006 14:00:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=etjqt/sf4n4CsRKLtwtlt0/9C7w4faqo8NoGACiS1NuSRLGPdTnZWq+a/BrowY24InGCeqogll5WZR7F03WL8ck21xvymVSe7ZcisYXllrYm7mkIHrRnb0lE60Pk5DHG47em00uW0OMovEfxehFnNBzUrAYCmm0MCo+ROlmJUWw=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [patch 11/14] remap_file_pages protection support: pte_present should not trigger on PTE_FILE PROTNONE ptes
Date: Sun, 7 May 2006 19:50:58 +0200
User-Agent: KMail/1.8.3
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Linux Memory Management <linux-mm@kvack.org>
References: <20060430172953.409399000@zion.home.lan> <200605030329.51034.blaisorblade@yahoo.it> <445C747A.7080205@yahoo.com.au>
In-Reply-To: <445C747A.7080205@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605071950.58712.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 06 May 2006 12:03, Nick Piggin wrote:
> Blaisorblade wrote:
> > On Tuesday 02 May 2006 05:53, Nick Piggin wrote:
> >>blaisorblade@yahoo.it wrote:
> >>>From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
> >>>
> >>>pte_present(pte) implies that pte_pfn(pte) is valid. Normally even with
> >>> a _PAGE_PROTNONE pte this holds, but not when such a PTE is installed
> >>> by the new install_file_pte; previously it didn't store protections,
> >>> only file offsets, with the patches it also stores protections, and can
> >>> set _PAGE_PROTNONE|_PAGE_FILE.
> >
> > What could be done is to set a PTE with "no protection", use another bit
> > rather than _PAGE_PROTNONE. This wastes one more bit but doable.

> I see.

> I guess your problem is that you're overloading the pte protection bits
> for present ptes as protection bits for not present (file) ptes. I'd rather
> you just used a different encoding for file pte protections then.

Yes, this is what I said above, so we agree; and indeed this overloading was 
decided when the present problem didn't trigger, so it can now change. As 
detailed in the patch description, the previous PageReserved handling 
prevented freeing page 0 and hided this.

> "Wasting" a bit seems much more preferable for this very uncommon case (for
> most people) rather than bloating pte_present check, which is called in
> practically every performance critical inner loop).

Yes, I thought about this problem, I wasn't sure how hard it was.

> That said, if the patch is i386/uml specific then I don't have much say in
> it.

It's presently specific, but will probably extend. Implementations for some 
other archs were already sent and I've collected them (will send 
afterwards,I've avoided excess bloat).

> If Ingo/Linus and Jeff/Yourself, respectively, accept the patch, then 
> fine.

> But I think you should drop the comment from the core code. It seems wrong.

Yep, forgot there, thanks for reminding, I've now removed it.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 
