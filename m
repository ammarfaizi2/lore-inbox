Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314270AbSDVQkP>; Mon, 22 Apr 2002 12:40:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314271AbSDVQkN>; Mon, 22 Apr 2002 12:40:13 -0400
Received: from imladris.infradead.org ([194.205.184.45]:9991 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S314270AbSDVQkJ>; Mon, 22 Apr 2002 12:40:09 -0400
Date: Mon, 22 Apr 2002 17:39:59 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] patch to /proc/meminfo to display NUMA stats
Message-ID: <20020422173958.A3557@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <25270000.1019495119@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 22, 2002 at 10:05:19AM -0700, Martin J. Bligh wrote:
> Below is a patch to /proc/meminfo to display free, used and total
> memory per node on a NUMA machine. It works fine on an ia32
> machine, but is not yet ready for submission until I make it generic.
> Before I go to the effort of doing that, I thought I'd seek some feedback.
> 
> Comments?

Sure.  First I wonder whether it would be possible to kill nr_free_pages()
and nr_free_highpages() (or infact all of the nr_free*page() functions)
in favour of the per-node ones, externalizing the for loop.  Or if there
are to many users at least make them use the per-node version.
Second I wonder whether nr_free_pages_node() and nr_free_highpages_node()
should take a pgdat instead of a node id as the caller has it around anyway.

Also I think the per-node info should be in /proc/meminfo even for UMA
machines, it doesn't hurt but makes it more consistant.
