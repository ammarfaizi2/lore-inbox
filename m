Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268368AbUHYT31@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268368AbUHYT31 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 15:29:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268365AbUHYT31
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 15:29:27 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:48769 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268368AbUHYT30
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 15:29:26 -0400
Date: Wed, 25 Aug 2004 20:29:22 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Paulo Marques <pmarques@grupopie.com>
Cc: Matt Mackall <mpm@selenic.com>, linux-kernel@vger.kernel.org,
       bcasavan@sgi.com
Subject: Re: [PATCH] kallsyms data size reduction / lookup speedup
Message-ID: <20040825192922.GH21964@parcelfarce.linux.theplanet.co.uk>
References: <1093406686.412c0fde79d4f@webmail.grupopie.com> <20040825173941.GJ5414@waste.org> <412CDE9D.3090609@grupopie.com> <20040825185854.GP31237@waste.org> <412CE3ED.5000803@grupopie.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <412CE3ED.5000803@grupopie.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2004 at 08:09:33PM +0100, Paulo Marques wrote:
> Matt Mackall wrote:
> >...
> >
> >FYI, killing the seq_file stuff will likely prove unpopular. So you'll
> >want to do that in a separate patch. If it doesn't affect the way
> >you're handling compression, please repost your compression patch. I
> >have a few comments, but otherwise I think we should move forward with it.
> 
> I'm still not sure that the seq_file is the culprit, but doing
> a 10000 symbol decompression in a user space application takes
> about 340us, whereas doing a "time cat /proc/kallsyms > /dev/null"
> gives approx. 0.2s! (this is all on a Pentium4 2.8GHz)
> 
> *If* the seq_file is the culprit, then I don't think removing
> it (or improving it) will be unpopular.

If it really spends that much in seq_file, I bet anything that it got
*very* dumb iterator.  Which should be fixable...
