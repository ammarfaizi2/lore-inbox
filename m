Return-Path: <linux-kernel-owner+w=401wt.eu-S1753693AbWL1UHl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753693AbWL1UHl (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 15:07:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753708AbWL1UHl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 15:07:41 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:36351 "EHLO inti.inf.utfsm.cl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753693AbWL1UHk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 15:07:40 -0500
Message-Id: <200612282007.kBSK7akx021051@laptop13.inf.utfsm.cl>
To: "=?ISO-8859-1?Q?Daniel_Marjam=E4ki?=" <daniel.marjamaki@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Want comments regarding patch 
In-Reply-To: Message from "=?ISO-8859-1?Q?Daniel_Marjam=E4ki?=" <daniel.marjamaki@gmail.com> 
   of "Thu, 28 Dec 2006 19:41:25 BST." <80ec54e90612281041q3b2c2bcemb0308c1e89a29ac@mail.gmail.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.5  (beta27)
Date: Thu, 28 Dec 2006 17:07:36 -0300
From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (inti.inf.utfsm.cl [200.1.21.155]); Thu, 28 Dec 2006 17:07:36 -0300 (CLST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Marjamäki <daniel.marjamaki@gmail.com> wrote:
> I sent a patch with this content:
> 
> -       for (i = 0; i < MAX_PIRQS; i++)
> -               pirq_entries[i] = -1;
> +       memset(pirq_entries, -1, sizeof(pirq_entries));
> 
> I'd like to know if you have any comments to this change. It was of
> course my intention to make the code shorter, simpler and faster.

- Is this code in some fast path? If so, I'd set up a constant array that
  is memcpy()'d over the variable (or used to initialize it) as needed.
- If not, what is the point? Shaving off a few bytes/cycles and paying for
  that with massive developer confusion? What if the constant changes and
  is -2, or 1, tomorrow?
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
Casilla 110-V, Valparaiso, Chile               Fax:  +56 32 2797513
