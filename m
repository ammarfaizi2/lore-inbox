Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263295AbTIAVrg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 17:47:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263308AbTIAVrg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 17:47:36 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:23057
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S263295AbTIAVrf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 17:47:35 -0400
Date: Mon, 1 Sep 2003 14:47:38 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Jeff Garzik <jgarzik@pobox.com>, Sam Ravnborg <sam@ravnborg.org>,
       Christoph Hellwig <hch@infradead.org>,
       Tigran Aivazian <tigran@veritas.com>, linux-kernel@vger.kernel.org,
       tigran@aivazian.fsnet.co.uk
Subject: Re: dontdiff for 2.6.0-test4
Message-ID: <20030901214738.GF31760@matchmail.com>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Christoph Hellwig <hch@infradead.org>,
	Tigran Aivazian <tigran@veritas.com>, linux-kernel@vger.kernel.org,
	tigran@aivazian.fsnet.co.uk
References: <Pine.GSO.4.44.0309010754480.1106-100000@north.veritas.com> <20030901163958.A24464@infradead.org> <20030901162244.GA1041@mars.ravnborg.org> <3F537CDD.3040809@pobox.com> <20030901171806.GB1041@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030901171806.GB1041@mars.ravnborg.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 01, 2003 at 07:18:06PM +0200, Sam Ravnborg wrote:
> On Mon, Sep 01, 2003 at 01:07:41PM -0400, Jeff Garzik wrote:
> > 
> > dontdiff must know about many things that 'make mrproper' need not care 
> > about:
> > 
> > 	files with ".bak" suffix
> > 	files with "~" suffix
> > 	BitKeeper, CVS, RCS, SCCS directories
> 
> make mrproper already cares about all those.
> Fragments from top-level Makefile:
> 
> RCS_FIND_IGNORE := \( -name SCCS -o -name BitKeeper -o -name .svn -o -name CVS \) -prune -o
> 
> mrproper:
>         @find . $(RCS_FIND_IGNORE) \
>                 \( -name '*.orig' -o -name '*.rej' -o -name '*~' \
>                 -o -name '*.bak' -o -name '#*#' -o -name '.*.orig' \
>                 -o -name '.*.rej' -o -size 0 \
>                 -o -name '*%' -o -name '.*.cmd' -o -name 'core' \) \
>                 -type f -print | xargs rm -f
>         $(call cmd,mrproper)
> 

But dontdiff is a list of files that must be skipped, not a regex, right?
Then dontdiff will be useless until a build has been done on that kernel tree.
