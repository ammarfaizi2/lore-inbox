Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129316AbRBIDjQ>; Thu, 8 Feb 2001 22:39:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129822AbRBIDjH>; Thu, 8 Feb 2001 22:39:07 -0500
Received: from gap.cco.caltech.edu ([131.215.139.43]:6868 "EHLO
	gap.cco.caltech.edu") by vger.kernel.org with ESMTP
	id <S129316AbRBIDiw>; Thu, 8 Feb 2001 22:38:52 -0500
Date: Thu, 8 Feb 2001 22:05:39 -0500
From: "Michael H. Warfield" <mhw@wittsend.com>
To: Aaron Denney <wnoise@ugcs.caltech.edu>
Cc: mlist-linux-kernel@NNTP-SERVER.CALTECH.EDU
Subject: Re: DNS goofups galore...
Message-ID: <20010208220539.C1642@alcove.wittsend.com>
Mail-Followup-To: Aaron Denney <wnoise@ugcs.caltech.edu>,
	mlist-linux-kernel@nntp-server.caltech.edu
In-Reply-To: <linux.kernel.20010208193120.C1640@alcove.wittsend.com> <slrn986j6c.ej0.wnoise@barter.ugcs.caltech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.2i
In-Reply-To: <slrn986j6c.ej0.wnoise@barter.ugcs.caltech.edu>; from wnoise@ugcs.caltech.edu on Fri, Feb 09, 2001 at 01:50:04AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 09, 2001 at 01:50:04AM +0000, Aaron Denney wrote:
> Michael H. Warfield <mhw@wittsend.com> wrote:
> > 	But, wait a minute.  CNAME -> CNAME is a "must not".

> Cite the RFC please.  1034 says

> # Domain names in RRs which point at another name should always point at
> # the primary name and not the alias.
> and 
> # domain software should not fail when presented with CNAME
> # chains or loops; CNAME chains should be followed and CNAME loops
> # signalled as an error.
> and
> #    - The answer to the query, possibly preface by one or more CNAME
> #      RRs that specify aliases encountered on the way to an answer.
> and
> # Multiple levels of
> # aliases should be avoided due to their lack of efficiency, but should
> # not be signalled as an error.

> It's fairly clear that CNAMEs to CNAMEs are discouraged, but legal.

	Hmmm...  Looks like I have had that just about backwards (par for
the course).  RFC 1912 (Common DNS Errors) makes it pretty clear that
other RRs should not point at CNAMEs and that would include CNAMEs
pointing at CNAMEs.  It quotes your same section, 3.6.2, of rfc 1034
for justifying that.

]   Don't use CNAMEs in combination with RRs which point to other names
]   like MX, CNAME, PTR and NS.  (PTR is an exception if you want to
]   implement classless in-addr delegation.)  For example, this is
]   strongly discouraged:
]
]           podunk.xx.      IN      MX      mailhost
]           mailhost        IN      CNAME   mary
]           mary            IN      A       1.2.3.4
]
]   [RFC 1034] in section 3.6.2 says this should not be done, and [RFC
]   974] explicitly states that MX records shall not point to an alias
]   defined by a CNAME.  This results in unnecessary indirection in
]   accessing the data, and DNS resolvers and servers need to work more
]   to get the answer.  If you really want to do this, you can accomplish
]   the same thing by using a preprocessor such as m4 on your host files.

	That pretty explicity states that MX records should not (and,
according to RFC 974, must not) point to CNAMES.

]   Also, having chained records such as CNAMEs pointing to CNAMEs may
]   make administration issues easier, but is known to tickle bugs in
]   some resolvers that fail to check loops correctly.  As a result some
]   hosts may not be able to resolve such names.

	That's a pretty strong recommendation to NOT point CNAMEs to
CNAMEs.  It's not a "must not", but it points out a seeming ambiguity in
RFC 1034.  The very passage you quote:

> # Domain names in RRs which point at another name should always point at
> # the primary name and not the alias.

	Doesn't that say that a domain name in a RR should always point
at the primary name.  Doesn't that imply (and thus semi contradict the
rest of that section about loops) that CNAMEs should not point to CNAMEs?

	That would appear to make rfc 1034 look ambiguous.  Section
3.6.2 says that RRs should always point to primary names but then
goes on to discuss CNAME loops and states that multiple levels of
aliases should not be signaled as an error.

	But then we are down to semantics and the semantics of the RFCs
are defined.  Should and should not are recommendations, not requirements.
Must and must not are requirements.  On that point, I must cede the field
and admit that both CNAME -> MX and CNAME -> CNAME would appear to fall
under the former and not the later.  But MX -> CNAME would appear to be
explicitly prohibited under RFC 974.

> -- 
> Aaron Denney
> -><-
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

	Mike
-- 
 Michael H. Warfield    |  (770) 985-6132   |  mhw@WittsEnd.com
  (The Mad Wizard)      |  (678) 463-0932   |  http://www.wittsend.com/mhw/
  NIC whois:  MHW9      |  An optimist believes we live in the best of all
 PGP Key: 0xDF1DD471    |  possible worlds.  A pessimist is sure of it!

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
