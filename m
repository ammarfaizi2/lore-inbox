Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262267AbVDFRzr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262267AbVDFRzr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 13:55:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262268AbVDFRzr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 13:55:47 -0400
Received: from az33egw01.freescale.net ([192.88.158.102]:49567 "EHLO
	az33egw01.freescale.net") by vger.kernel.org with ESMTP
	id S262267AbVDFRzo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 13:55:44 -0400
In-Reply-To: <Pine.LNX.4.58.0504061006120.4635@graphe.net>
References: <Pine.LNX.4.58.0504061006120.4635@graphe.net>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <1a0fc11558f3bf76d1a8ab889278dcc7@freescale.com>
Content-Transfer-Encoding: 8BIT
Cc: "Nick Piggin" <nickpiggin@yahoo.com.au>,
       "LKML list" <linux-kernel@vger.kernel.org>
From: Kumar Gala <kumar.gala@freescale.com>
Subject: Re: return value of ptep_get_and_clear
Date: Wed, 6 Apr 2005 12:55:36 -0500
To: "Christoph Lameter" <christoph@lameter.com>
X-Mailer: Apple Mail (2.619.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Apr 6, 2005, at 12:09 PM, Christoph Lameter wrote:

> On Thu, 7 Apr 2005, Nick Piggin wrote:
>
> > Kumar Gala wrote:
>  > > ptep_get_and_clear has a signature that looks something like:
> > >
>  > > static inline pte_t ptep_get_and_clear(struct mm_struct *mm, 
> unsigned
> > > long addr,
>  > >                                        pte_t *ptep)
>  > >
>  > > It appears that its suppose to return the pte_t pointed to by ptep
>  > > before its modified.  Why do we bother doing this?  The caller 
> seems
>  > > perfectly able to dereference ptep and hold on to it.  Am I 
> missing
>  > > something here?
>  > >
>  >
>  > You need to be able to *atomically* clear the pte and retrieve the
>  > old value.
>
> The effect of the clearing is that the present bit is cleared which 
> makes
>  the CPU generate a fault if this pte is referenced.
>
> The problem with replacing pte values is that the code executing is 
> racing
>  with cpu mmu access to the pte (which may set bits on i386 I 
> believe). So
>  if you would access the pte and then clear it later then there would 
> be a
>  small window where the MMU could modify the pte. These changes would 
> not
>  be detected since you later overwrite the pte.
>
> Using ptep_get_and_clear insures that this does not happen...

Thanks, I was guessing that getting the value atomically was why this 
was done after I give it a bit more thought.

- kumar

