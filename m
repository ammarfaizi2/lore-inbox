Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318040AbSHLORk>; Mon, 12 Aug 2002 10:17:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318045AbSHLORk>; Mon, 12 Aug 2002 10:17:40 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:10761 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S318040AbSHLORj>; Mon, 12 Aug 2002 10:17:39 -0400
Date: Mon, 12 Aug 2002 11:21:16 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Christian Ehrhardt <ehrhardt@mathematik.uni-ulm.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: pte_chain leak in rmap code (2.5.31)
In-Reply-To: <20020812134527.18720.qmail@thales.mathematik.uni-ulm.de>
Message-ID: <Pine.LNX.4.44L.0208121119270.23404-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Aug 2002, Christian Ehrhardt wrote:

> Note the strange use of continue and break which both achieve the same!
> What was meant to happen (judging from rmap-13c) is that we break
> out of the for-Loop once SWAP_FAIL or SWAP_ERROR is returned from
> try_to_unmap_one. However, this doesn't happen and a subsequent call
> to pte_chain_free will use the wrong value for prev_pc.

Excellent hunting!   Thank you!

Your fix should work too, although in my opinion it's a
little bit too subtle, so I've changed it into:

	                                case SWAP_FAIL:
                                        ret = SWAP_FAIL;
                                        goto give_up;
                                case SWAP_ERROR:
                                        ret = SWAP_ERROR;
                                        goto give_up;
                        }
                }
give_up:

This is going into 2.4-rmap and 2.5 right now.

thanks,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

