Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965491AbWIRGpk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965491AbWIRGpk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 02:45:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965487AbWIRGpk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 02:45:40 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:16258 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965486AbWIRGpj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 02:45:39 -0400
Subject: Re: [patch 1/8] extend make headers_check to detect more problems
From: David Woodhouse <dwmw2@infradead.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060918062152.GA7088@uranus.ravnborg.org>
References: <20060918012740.407846000@klappe.arndb.de>
	 <20060918013216.335200000@klappe.arndb.de>
	 <20060918062152.GA7088@uranus.ravnborg.org>
Content-Type: text/plain
Date: Mon, 18 Sep 2006 07:45:36 +0100
Message-Id: <1158561937.24527.277.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-09-18 at 08:21 +0200, Sam Ravnborg wrote:
> Can't we do this with a hdrchk$$$ filename to avoid using
> random entropy for each compile? 

I'd like to move to a scheme where we do headers_install and
headers_check _without_ starting with a rm -rf
$(HDR_INSTALL_PATH)/include.

We could probably do it by adding a rule along the lines of
$(filter-out $(unifdef-y) $(header-y),$(wildcard $(INSTALL_HDR_PATH)/$(dst)/*.h):
	rm $@
... i.e. remove every .h file from the destination directory except the
ones we just created. 

Then we can make $(INSTALL_HDR_PATH)/$(dst)/%.h depend on
$(srctree)/$(src)/%.h so that it doesn't get re-exported unless it's
changed. And we can keep a stamp file around (or the output of the test
compilation after Arnd's patch) which shows that the _check_ step has
been done too. Something like .checked.%.h

After we do that, a second invocation of 'make headers_check' should
have nothing to do, which will encourage people to keep using it.

-- 
dwmw2

