Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030437AbWJKB3J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030437AbWJKB3J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 21:29:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030436AbWJKB3J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 21:29:09 -0400
Received: from rgminet01.oracle.com ([148.87.113.118]:25760 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1030437AbWJKB3G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 21:29:06 -0400
Date: Tue, 10 Oct 2006 18:28:51 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: Matt Helsley <matthltc@us.ibm.com>
Cc: Paul Menage <menage@google.com>, linux-kernel@vger.kernel.org,
       Chandra Seetharaman <sekharan@us.ibm.com>,
       ckrm-tech@lists.sourceforge.net
Subject: Re: [ckrm-tech] [PATCH 0/5] Allow more than PAGESIZE data read in configfs
Message-ID: <20061011012851.GR7911@ca-server1.us.oracle.com>
Mail-Followup-To: Matt Helsley <matthltc@us.ibm.com>,
	Paul Menage <menage@google.com>, linux-kernel@vger.kernel.org,
	Chandra Seetharaman <sekharan@us.ibm.com>,
	ckrm-tech@lists.sourceforge.net
References: <20061010182043.20990.83892.sendpatchset@localhost.localdomain> <20061010203511.GF7911@ca-server1.us.oracle.com> <6599ad830610101431j33a5dc55h6878d5bc6db91e85@mail.gmail.com> <20061010215808.GK7911@ca-server1.us.oracle.com> <1160527799.1674.91.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1160527799.1674.91.camel@localhost.localdomain>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2006 at 05:49:59PM -0700, Matt Helsley wrote:
> 	We want to be able to export a sequence of small (<< 1 page),
> homogenous, unstructured (scalar), attributes through configfs using the
> same file. While this is rather specific, I'd guess it would be a common
> occurrence.

	Pray tell, why?  "One attribute per file" is the mantra here.
You really should think hard before you break it.  Simple heuristic:
would you have to parse the buffer?  Then it's wrong.

> 	Yes, keeping track of writing to these sequences (add, remove, replace)
> is a problem. But that's what the file position is for. configfs could
> 
> 	Does this seem reasonable?

	No.  It adds complexity to an interface that is supposed to be
simple.  Now, I'm not sure what you are trying to do here, so I don't
know how it fits in.  Is it really "multiple attributes per file", or
"this attribute is a list of entries"?
	An example.  If you had to set an IP address and a port, here's
your scenarios:

[Right]
    echo "10.0.0.1" > /sys/kernel/config/subsys/item/address
    echo "8000" > /sys/kernel/config/subsys/item/port

[Wrong]
    echo 10.0.0.1\n8000" > /sys/kernel/config/subsys/item/address-and-port

	But perhaps you are not setting two distinct attributes.  I
don't understand what you are doing, so some detail would be nice.

Joel

-- 

Life's Little Instruction Book #407

	"Every once in a while, take the scenic route."

Joel Becker
Principal Software Developer
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
