Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946206AbWJSQyi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946206AbWJSQyi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 12:54:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946229AbWJSQyi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 12:54:38 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:9609 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1946206AbWJSQyh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 12:54:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=dSMca8zePGkfgRG0l9fnqQPVdRpp616+ccDZivHrs8GPWAanvXdUhF+k5umfDkfcDhS30ibswO0LIV9cjYwAg5JcUsYZGxbqtC4ZYX3RiExdF2absLV8gXQ4RPIayGwnxcGI8EtgLSdJ4hYigervInqz5MMWkugizpAFzlpOzLk=
From: Denis Vlasenko <vda.linux@googlemail.com>
To: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [RFC] typechecking for get_unaligned/put_unaligned
Date: Thu, 19 Oct 2006 18:52:50 +0200
User-Agent: KMail/1.8.2
Cc: Dave Jones <davej@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
References: <20061017005025.GF29920@ftp.linux.org.uk> <20061018054242.GA21266@redhat.com> <20061018060500.GI29920@ftp.linux.org.uk>
In-Reply-To: <20061018060500.GI29920@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610191852.50967.vda.linux@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 18 October 2006 08:05, Al Viro wrote:
> That's the point, actually - apparently we have several high-impact includes
> that are easy to sever and that are really worth being severed.  The part
> that was not aproiri obvious:
> 	* there are clusters of headers around certain dependency
> counts.
> 	* such clusters tend to have leaders - header that pulls the
> rest and even though other headers are apparently independently included,
> all such includes end up being hidden by includes of the leader.
> 	* gaps between the clusters are pretty large.
> 	* dependency graph *on* *clusters* is worth being studied; includes
> of cluster leader from cluster around slightly smaller dependency count
> are prime targets for severing.
> 
> That is the new part here.  Not just "dependency graph is a mess and ought
> to be cleaned up" - _that_ is neither new nor particulary useful...

Well, logically for any given .config a set of all kernel header files
define a set of typedefs, structs, functions and so on.
If only we can read and parse them just once, and then reuse
already parsed information when we compile each .c file -
that will give you the biggest time savings.

gcc has some facility for that ("precompiled headers")
http://gcc.gnu.org/onlinedocs/gcc/Precompiled-Headers.html

I don't know how hard it will be to adapt build system to using that
and there is a danger that using this thing will increase
recompile times when you change just a few CONFIG_XXXs.
--
vda
