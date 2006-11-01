Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992674AbWKAQzz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992674AbWKAQzz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 11:55:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992675AbWKAQzz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 11:55:55 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:1233 "EHLO
	out1.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S2992674AbWKAQzy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 11:55:54 -0500
X-Sasl-enc: JAA/qIvWsjnYJ/SsAKlNVhsGrksgURYFTWRAcms96yZD 1162400153
Date: Wed, 1 Nov 2006 13:55:42 -0300
From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
To: Shem Multinymous <multinymous@gmail.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
       Richard Hughes <hughsient@gmail.com>,
       Xavier Bestel <xavier.bestel@free.fr>,
       Jean Delvare <khali@linux-fr.org>, davidz@redhat.com,
       Dan Williams <dcbw@redhat.com>, linux-kernel@vger.kernel.org,
       devel@laptop.org, sfr@canb.auug.org.au, len.brown@intel.com,
       greg@kroah.com, benh@kernel.crashing.org,
       linux-thinkpad mailing list <linux-thinkpad@linux-thinkpad.org>,
       Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH v2] Re: Battery class driver.
Message-ID: <20061101165542.GA24989@khazad-dum.debian.net>
References: <41840b750610281112q7790ecao774b3d1b375aca9b@mail.gmail.com> <6DP6m926.1162281579.9733640.khali@localhost> <41840b750610310542u2bbcf4b6y5f9f812ebd12445@mail.gmail.com> <1162302686.31012.47.camel@frg-rhel40-em64t-03> <41840b750610310606t2b21d277k724f868cb296d17f@mail.gmail.com> <1162387577.5001.7.camel@hughsie-laptop> <1162389260.18406.62.camel@shinybook.infradead.org> <20061101143634.GB12619@khazad-dum.debian.net> <41840b750611010836qe9d49a0q6c5179babd6bc137@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41840b750611010836qe9d49a0q6c5179babd6bc137@mail.gmail.com>
X-GPG-Fingerprint: 1024D/1CDB0FE3 5422 5C61 F6B7 06FB 7E04  3738 EE25 DE3F 1CDB 0FE3
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 01 Nov 2006, Shem Multinymous wrote:
> On 11/1/06, Henrique de Moraes Holschuh <hmh@hmh.eng.br> wrote:
> >On Wed, 01 Nov 2006, David Woodhouse wrote:
> >> On Wed, 2006-11-01 at 13:26 +0000, Richard Hughes wrote:
> >> > With the battery class driver, how would that be conveyed? Would the
> >> > sysfs file be deleted in this case, or would the value of the sysfs
> >> > key be something like "<invalid>".
> >>
> >> I'd be inclined to make the read return -EINVAL.
> >
> >-EIO for transient errors (e.g. access to the embedded controller/battery
> >charger/whatever fails at that instant), -EINVAL for "not supported"
> >(missing ACPI method, attribute not supported in the specific hardware)?
> 
> Shouldn't it be -EIO or -EBUSY for transient errors (depending on
> type), and -ENXIO when not provided by hardware?

Sounds good to me, but I haven't seen much stuff returning -ENXIO.  Still,
AFAIK usually when you don't support something in sysfs, you don't provide
the entry at all so ENXIO should be quite rare.

> The -EINVAL is more appropriate for bad user-supplied values (out of
> range etc.) to writable attributes.

Yes, that makes a lot of sense.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
