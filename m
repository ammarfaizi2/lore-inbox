Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751176AbWFLQ3z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751176AbWFLQ3z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 12:29:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752125AbWFLQ3y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 12:29:54 -0400
Received: from cantor.suse.de ([195.135.220.2]:56718 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751176AbWFLQ3y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 12:29:54 -0400
From: Andreas Gruenbacher <agruen@suse.de>
Organization: Novell, SUSE Labs
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [RFC PATCH] kbuild support for %.symtypes files
Date: Mon, 12 Jun 2006 18:32:05 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, Jon Masters <jcm@redhat.com>
References: <200605092037.31228.agruen@suse.de> <20060610203348.GB9502@mars.ravnborg.org>
In-Reply-To: <20060610203348.GB9502@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606121832.05599.agruen@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, 10 June 2006 22:33, Sam Ravnborg wrote:
> On Tue, May 09, 2006 at 08:37:30PM +0200, Andreas Gruenbacher wrote:
> > Hello,
> >
> > here is a patch that adds a new -T option to genksyms for generating
> > dumps of the type definition that makes up the symbol version hashes.
> > This allows to trace modversion changes back to what caused them. The
> > dump format is the name of the type defined, followed by its definition
> > (which is almost C):
> >
> >   s#list_head struct list_head { s#list_head * next , * prev ; }
>
> Reading something just a little more complex than the above was very
> difficult. So I went on and updated your patch to spit out something
> almost 'C' alike with proper indention and a few newlines too.
>
> The list_head struct looks like this now:
>
> struct#list_head  struct list_head {
> 	struct# list_head * next , * prev;
> };
>
> The real win is for structs with 20+ members, they are now divided up in
> several lines.

Please let's not beautify the output: this would make diffing and grepping 
harder. It's easy to pipe the simple, line oriented format through a 
formatting filter if necessary.

The output could be made more readable by converting the "x#" prefix to C 
keywords (struct, union, etc.). I didn't do this because that would introduce 
parse problems, and constructing dependency graphs from the dump files would 
become tricky.

Andreas

-- 
Andreas Gruenbacher <agruen@suse.de>
Novell / SUSE Labs
