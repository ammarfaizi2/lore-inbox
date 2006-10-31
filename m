Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423251AbWJaNmO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423251AbWJaNmO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 08:42:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423254AbWJaNmO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 08:42:14 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:26077 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1423251AbWJaNmN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 08:42:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SUsk8Hhv+oRNAKWFApkw4hq2THHseOpnmQbg8g+oYIKeiHi9o4LZblysOsRQht/rj9hQ8+E13uJDsdkuShwmRauekfpU+8SgtgqZli5FhBy0RXjrIHOPhoYc9y9tGrVROAUZMp0pH0XqgDATZoiPI/Q5QGq9cwQiwewJ7z/CwBY=
Message-ID: <41840b750610310542u2bbcf4b6y5f9f812ebd12445@mail.gmail.com>
Date: Tue, 31 Oct 2006 15:42:12 +0200
From: "Shem Multinymous" <multinymous@gmail.com>
To: "Jean Delvare" <khali@linux-fr.org>
Subject: Re: [PATCH v2] Re: Battery class driver.
Cc: davidz@redhat.com, "Richard Hughes" <hughsient@gmail.com>,
       "David Woodhouse" <dwmw2@infradead.org>,
       "Dan Williams" <dcbw@redhat.com>, linux-kernel@vger.kernel.org,
       devel@laptop.org, sfr@canb.auug.org.au, len.brown@intel.com,
       greg@kroah.com, benh@kernel.crashing.org,
       "linux-thinkpad mailing list" <linux-thinkpad@linux-thinkpad.org>,
       "Pavel Machek" <pavel@suse.cz>
In-Reply-To: <6DP6m926.1162281579.9733640.khali@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <41840b750610281112q7790ecao774b3d1b375aca9b@mail.gmail.com>
	 <6DP6m926.1162281579.9733640.khali@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean,

On 10/31/06, Jean Delvare <khali@linux-fr.org> wrote:
> On 10/28/2006, someone who remains multinymous wrote:
> >On 10/28/06, David Zeuthen <davidz@redhat.com> wrote:
> >> What about just prepending the unit to the 'threshold' file? Then user
> >> space can expect the contents of said file to be of the form "%d %s". I
> >> don't think that violates the "only one value per file" sysfs mantra.

> >Jean, what's your opinion on letting hwmon-ish attributes specify
> >units as "%d %s" where these are hardware-dependent?
>
> I fail to see any benefit in doing so, while I see several problems (see
> above) and potential for confusion. So my opinion is: please don't do
> that.

Well, we have to do *something* about those devices that don't have
fixed units (see my mail to Greg from a few minutes ago), so which
alternative do you prefer?


> >The tp_smapi battery driver did just this  ("16495 mW"). But I dropped
> >it in a recent version when Pavel pointed out the rest of sysfs, hwmon
> >included, uses undecorated integers.
> >Consistency aside, it seems reasonable and convenient. You have to
> >decree that writes to the attributes (where relevant) don't include
> >the units, of course, so no one will expect the kernel to parse that.
>
> But what value should then be written? One in an absolute aribtrary unit?
> That would make reads and writes to the sysfs files inconsistent, in
> direct violation of the sysfs standard. Or in the same unit read from
> the file? It means that userspace must first read from the file, parse
> the unit, then convert the value to be written. This doesn't match my
> definition of "convenient".

The latter. Yes, writing is not as convenient as reading; but the same
drawback exists in the other two suggestions for dynamic units - you
still have to read another attribute, or parse a filename, to get the
units.

The "capacity_remaining:mV" option at least saves you the parsing if
your're only interested in mV readouts. But battery gauge applets, for
examples, shouldn't be hardcoded to specific units, so they will have
to do the filename parsing dance.


 Shem
