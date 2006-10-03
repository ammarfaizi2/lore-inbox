Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932276AbWJCQph@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932276AbWJCQph (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 12:45:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932281AbWJCQph
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 12:45:37 -0400
Received: from anyanka.rfc1149.net ([81.56.47.149]:23781 "EHLO
	mail2.rfc1149.net") by vger.kernel.org with ESMTP id S932276AbWJCQpg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 12:45:36 -0400
Date: Tue, 3 Oct 2006 18:45:35 +0200
To: Jean Tourrilhes <jt@hpl.hp.com>
Cc: Pavel Roskin <proski@gnu.org>, "John W. Linville" <linville@tuxdriver.com>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: 2.6.18-mm2 - oops in cache_alloc_refill()
References: <20060928014623.ccc9b885.akpm@osdl.org> <200609290319.k8T3JOwS005455@turing-police.cc.vt.edu> <20060928202931.dc324339.akpm@osdl.org> <200609291519.k8TFJfvw004256@turing-police.cc.vt.edu> <20060929124558.33ef6c75.akpm@osdl.org> <200609300001.k8U01sPI004389@turing-police.cc.vt.edu> <20060929182008.fee2a229.akpm@osdl.org> <20061002175245.GA14744@bougret.hpl.hp.com> <2006-10-03-17-58-31+trackit+sam@rfc1149.net> <20061003163415.GA17252@bougret.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061003163415.GA17252@bougret.hpl.hp.com>
User-Agent: Mutt/1.5.11
From: Samuel Tardieu <sam@rfc1149.net>
Organization: RFC 1149 (see http://www.rfc1149.net/)
Content-Transfer-Encoding: 8bit
X-WWW: http://www.rfc1149.net/sam
X-Jabber: <sam@rfc1149.net> (see http://www.jabber.org/)
X-OpenPGP-Fingerprint: 79C0 AE3C CEA8 F17B 0EF1  45A5 F133 2241 1B80 ADE6 (see http://www.gnupg.org/)
Message-Id: <2006-10-03-18-45-35+trackit+sam@rfc1149.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  3/10, Jean Tourrilhes wrote:

| > I suggest that you revert the memset() to IW_ESSID_MAX_SIZE+1 so that
| > the last byte is cleared as well. Or am I missing something?
| 
| No, that would bring back the slab/memory overflow we are
| trying to get rid of.

Then I am puzzled by the function declaration:

static int orinoco_hw_get_essid(struct orinoco_private *priv, int *active,
                                char buf[IW_ESSID_MAX_SIZE+1])

Do you mean that this function is called with a buf parameter which
doesn't have the expected size? (as far as the function declaration is
concerned) Shouldn't the declaration be changed to

static int orinoco_hw_get_essid(struct orinoco_private *priv, int *active,
                                char buf[IW_ESSID_MAX_SIZE])

then to reflect the reality? (it won't change the code but would be
clearer from a documentation point of view)

 Sam

