Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262969AbTIARSQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 13:18:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263154AbTIARSP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 13:18:15 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:8209 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S262969AbTIARSI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 13:18:08 -0400
Date: Mon, 1 Sep 2003 19:18:06 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Sam Ravnborg <sam@ravnborg.org>, Christoph Hellwig <hch@infradead.org>,
       Tigran Aivazian <tigran@veritas.com>, linux-kernel@vger.kernel.org,
       tigran@aivazian.fsnet.co.uk
Subject: Re: dontdiff for 2.6.0-test4
Message-ID: <20030901171806.GB1041@mars.ravnborg.org>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Christoph Hellwig <hch@infradead.org>,
	Tigran Aivazian <tigran@veritas.com>, linux-kernel@vger.kernel.org,
	tigran@aivazian.fsnet.co.uk
References: <Pine.GSO.4.44.0309010754480.1106-100000@north.veritas.com> <20030901163958.A24464@infradead.org> <20030901162244.GA1041@mars.ravnborg.org> <3F537CDD.3040809@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F537CDD.3040809@pobox.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 01, 2003 at 01:07:41PM -0400, Jeff Garzik wrote:
> 
> dontdiff must know about many things that 'make mrproper' need not care 
> about:
> 
> 	files with ".bak" suffix
> 	files with "~" suffix
> 	BitKeeper, CVS, RCS, SCCS directories

make mrproper already cares about all those.
Fragments from top-level Makefile:

RCS_FIND_IGNORE := \( -name SCCS -o -name BitKeeper -o -name .svn -o -name CVS \) -prune -o

mrproper:
        @find . $(RCS_FIND_IGNORE) \
                \( -name '*.orig' -o -name '*.rej' -o -name '*~' \
                -o -name '*.bak' -o -name '#*#' -o -name '.*.orig' \
                -o -name '.*.rej' -o -size 0 \
                -o -name '*%' -o -name '.*.cmd' -o -name 'core' \) \
                -type f -print | xargs rm -f
        $(call cmd,mrproper)


	Sam
