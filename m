Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992786AbWKATxQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992786AbWKATxQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 14:53:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992787AbWKATxQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 14:53:16 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:10415 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S2992786AbWKATxP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 14:53:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IxkhP8doDc/YwjmE4kUDnMuRAnI/uP7+tDyE0Mt8bafmPViW6THLlMGea3aHrcYbHBzepkibERhjMuUY5F6EvSHdAZF9vnPqRXFaZOPklwBdJOv/jUkJcWlawfLjwtz9//h89KhxChPI+A0ehtYBwbpr7+iWqarEO6Z4LFXfQxU=
Message-ID: <41840b750611011153w3a2ace72tcdb45a446e8298@mail.gmail.com>
Date: Wed, 1 Nov 2006 21:53:12 +0200
From: "Shem Multinymous" <multinymous@gmail.com>
To: "Greg KH" <greg@kroah.com>
Subject: Re: [PATCH v2] Re: Battery class driver.
Cc: "David Zeuthen" <davidz@redhat.com>,
       "Richard Hughes" <hughsient@gmail.com>,
       "David Woodhouse" <dwmw2@infradead.org>,
       "Dan Williams" <dcbw@redhat.com>, linux-kernel@vger.kernel.org,
       devel@laptop.org, sfr@canb.auug.org.au, len.brown@intel.com,
       benh@kernel.crashing.org,
       "linux-thinkpad mailing list" <linux-thinkpad@linux-thinkpad.org>,
       "Pavel Machek" <pavel@suse.cz>, "Jean Delvare" <khali@linux-fr.org>
In-Reply-To: <20061101193134.GB29929@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1161778296.27622.85.camel@shinybook.infradead.org>
	 <1161815138.27622.139.camel@shinybook.infradead.org>
	 <41840b750610251639t637cd590w1605d5fc8e10cd4d@mail.gmail.com>
	 <1162037754.19446.502.camel@pmac.infradead.org>
	 <1162041726.16799.1.camel@hughsie-laptop>
	 <1162048148.2723.61.camel@zelda.fubar.dk>
	 <41840b750610281112q7790ecao774b3d1b375aca9b@mail.gmail.com>
	 <20061031074946.GA7906@kroah.com>
	 <41840b750610310528p4b60d076v89fc7611a0943433@mail.gmail.com>
	 <20061101193134.GB29929@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 11/1/06, Greg KH <greg@kroah.com> wrote:
> > The suggestions so far were:
> > 1. Append units string to the content of such attribute:
> >   /sys/.../capacity_remaining reads "16495 mW".
> > 2. Add a seprate *_units attribute saying what are units for other
> > attribute:
> >   /sys/.../capacity_units gives the units for
> >   /sys/.../capacity_{remaining,last_full,design,min,...}.
> > 3. Append the units to the attribute names:
> >   capacity_{remaining,last_full,design_min,...}:mV.
>
> No, again, one for power and one for current.  Two different files
> depending on the type of battery present.  That way there is no need to
> worry about unit issues.

I'm missing something. How is that different from option 3 above?
BTW, please note that we're talking about a large set of files that
use these units (remaining, last full, design capacity, alarm
thresholds, etc.), and not just a single attribute.

This particular alternative indeed seems cleanest for the kernel side.
The drawback is that someone in userspace who doesn't care about units
but just wants to show a status report or compute the amount of
remaining fooergy divided by the amount of a fooergy when fully
charged, like your typical battery applet, will need to parse
filenames (or try out a fixed and possibly partial list) to find out
which attribute files contain the numbers.

  Shem
