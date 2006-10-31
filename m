Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161451AbWJaA17@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161451AbWJaA17 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 19:27:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751737AbWJaA17
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 19:27:59 -0500
Received: from quickstop.soohrt.org ([85.131.246.152]:23769 "EHLO
	quickstop.soohrt.org") by vger.kernel.org with ESMTP
	id S1751319AbWJaA16 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 19:27:58 -0500
Date: Tue, 31 Oct 2006 01:27:57 +0100
From: Horst Schirmeier <horst@schirmeier.com>
To: Oleg Verych <olecom@flower.upol.cz>
Cc: Valdis.Kletnieks@vt.edu, Jan Beulich <jbeulich@novell.com>, dsd@gentoo.org,
       kernel@gentoo.org, draconx@gmail.com, jpdenheijer@gmail.com,
       Andrew Morton <akpm@osdl.org>, Sam Ravnborg <sam@ravnborg.org>,
       Andi Kleen <ak@suse.de>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -mm] replacement for broken kbuild-dont-put-temp-files-in-the-source-tree.patch
Message-ID: <20061031002757.GF2933@quickstop.soohrt.org>
Mail-Followup-To: Oleg Verych <olecom@flower.upol.cz>,
	Valdis.Kletnieks@vt.edu, Jan Beulich <jbeulich@novell.com>,
	dsd@gentoo.org, kernel@gentoo.org, draconx@gmail.com,
	jpdenheijer@gmail.com, Andrew Morton <akpm@osdl.org>,
	Sam Ravnborg <sam@ravnborg.org>, Andi Kleen <ak@suse.de>,
	LKML <linux-kernel@vger.kernel.org>
References: <20061029120858.GB3491@quickstop.soohrt.org> <200610290816.55886.ak@suse.de> <slrnek9qv0.2vm.olecom@flower.upol.cz> <20061029225234.GA31648@uranus.ravnborg.org> <4545C2D8.76E4.0078.0@novell.com> <slrnekbv60.2vm.olecom@flower.upol.cz> <slrnekc3q8.2vm.olecom@flower.upol.cz> <200610301522.k9UFMXmM004701@turing-police.cc.vt.edu> <slrnekc8np.2vm.olecom@flower.upol.cz> <slrnekcu6m.2vm.olecom@flower.upol.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <slrnekcu6m.2vm.olecom@flower.upol.cz>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Oct 2006, Oleg Verych wrote:
> +# Immortal null for mortals and roots
> +define null
> +  $(shell \
> +    if test -L null; \
> +      then echo null; \
> +      else rm -f null; ln -s /dev/null null; \
> +    fi)
> +endef

Another remark: the 'else' branch should echo null, too.

# Immortal null for mortals and roots
define null
  $(shell \
    if test ! -L null; \
      then rm -f null; ln -s /dev/null null; \
    fi; \
    echo null)
endef

My patch proposal (the $(M) one) has the same bug.

Kind regards,
 Horst

-- 
PGP-Key 0xD40E0E7A
