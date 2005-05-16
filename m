Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261511AbVEPJbm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261511AbVEPJbm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 05:31:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261516AbVEPJbm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 05:31:42 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:52647 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261511AbVEPJbi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 05:31:38 -0400
Subject: Re: Sync option destroys flash!
From: David Woodhouse <dwmw2@infradead.org>
To: Mark Lord <lkml@rtr.ca>
Cc: Denis Vlasenko <vda@ilport.com.ua>, mhw@wittsend.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <4287E807.6070502@rtr.ca>
References: <1116001207.5239.38.camel@localhost.localdomain>
	 <200505152200.26432.vda@ilport.com.ua>  <4287E807.6070502@rtr.ca>
Content-Type: text/plain
Date: Mon, 16 May 2005 10:29:48 +0100
Message-Id: <1116235789.25594.19.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-05-15 at 20:23 -0400, Mark Lord wrote:
> All flashcards (other than dumb "smart media" cards) have integrated
> NAND controllers which perform automatic page/block remapping and
> which implement various wear-leveling algorithms. Rewriting "Sector 0"
> 10000 times probably only writes once to the first sector of a 1GB card.
> The other writes are spread around the rest of the card, and remapped
> logically by the integrated controller.

Assuming the firmware of the card is written with a modicum of clue,
this is true. It's not clear how valid that assumption is, in the
general case. There are reports of cards behaving as if they have almost
no wear levelling at all.

> Linux could be more clever about it all, though.  Wear-leveling can only
> be done efficiently on "unused" or "rewritten" blocks/pages on the cards,
> and not so well with areas that hold large static data files (from the point
> of view of the flash controller, not the O/S).
> 
> If we were really clever about it, then when Linux deletes a file from a
> flashcard device, it would also issue CFA ERASE commands for the newly
> freed sectors.  This would let the card's controller know that it can
> remap/reuse that area of the card as it sees fit.

This would be extremely useful, yes. I've said in the past that I want
this for the benefit of the purely software flash translation layers
(FTL, NFTL etc.). I hadn't realised that CF cards expose the same
functionality.

-- 
dwmw2

