Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751247AbWJ1SMo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751247AbWJ1SMo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 14:12:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbWJ1SMn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 14:12:43 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:24167 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751247AbWJ1SMn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 14:12:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XwAB/Mo+2Sls9a4Jb6DHg+4kEE3Swiz5xcYpX1eTttnlKJNkNnV54tdzX4YYyqkqdN1Ek3oPFoNkPWhUVq8PNjV+n+HEx7BZUB2qm7ByXsqwcCq+zzJ83gOl+o5brmxrjtAlgU1Ei1/9UO+ySYpIr3aGJpS64ltcF3I+0cRc7lY=
Message-ID: <41840b750610281112q7790ecao774b3d1b375aca9b@mail.gmail.com>
Date: Sat, 28 Oct 2006 20:12:41 +0200
From: "Shem Multinymous" <multinymous@gmail.com>
To: "David Zeuthen" <davidz@redhat.com>
Subject: Re: [PATCH v2] Re: Battery class driver.
Cc: "Richard Hughes" <hughsient@gmail.com>,
       "David Woodhouse" <dwmw2@infradead.org>,
       "Dan Williams" <dcbw@redhat.com>, linux-kernel@vger.kernel.org,
       devel@laptop.org, sfr@canb.auug.org.au, len.brown@intel.com,
       greg@kroah.com, benh@kernel.crashing.org,
       "linux-thinkpad mailing list" <linux-thinkpad@linux-thinkpad.org>,
       "Pavel Machek" <pavel@suse.cz>, "Jean Delvare" <khali@linux-fr.org>
In-Reply-To: <1162048148.2723.61.camel@zelda.fubar.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1161628327.19446.391.camel@pmac.infradead.org>
	 <1161762158.27622.72.camel@shinybook.infradead.org>
	 <41840b750610250254x78b8da17t63ee69d5c1cf70ce@mail.gmail.com>
	 <1161778296.27622.85.camel@shinybook.infradead.org>
	 <41840b750610250742p7ad24af9va374d9fa4800708a@mail.gmail.com>
	 <1161815138.27622.139.camel@shinybook.infradead.org>
	 <41840b750610251639t637cd590w1605d5fc8e10cd4d@mail.gmail.com>
	 <1162037754.19446.502.camel@pmac.infradead.org>
	 <1162041726.16799.1.camel@hughsie-laptop>
	 <1162048148.2723.61.camel@zelda.fubar.dk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On 10/28/06, David Zeuthen <davidz@redhat.com> wrote:
> What about just prepending the unit to the 'threshold' file? Then user
> space can expect the contents of said file to be of the form "%d %s". I
> don't think that violates the "only one value per file" sysfs mantra.

The tp_smapi battery driver did just this  ("16495 mW"). But I dropped
it in a recent version when Pavel pointed out the rest of sysfs, hwmon
included, uses undecorated integers.
Consistency aside, it seems reasonable and convenient. You have to
decree that writes to the attributes (where relevant) don't include
the units, of course, so no one will expect the kernel to parse that.

There's an issue here if a drunk driver decides to specify (say)
capacity_remaining in mWh and capacity_last_full in mAa, which will
confuse anyone comparing those attributest. So don't do that.

Jean, what's your opinion on letting hwmon-ish attributes specify
units as "%d %s" where these are hardware-dependent?

  Shem
