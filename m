Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422928AbWJaIG7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422928AbWJaIG7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 03:06:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422943AbWJaIGu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 03:06:50 -0500
Received: from zone4.gcu.info ([217.195.17.234]:60111 "EHLO
	zone4.gcu-squad.org") by vger.kernel.org with ESMTP
	id S1422928AbWJaIGr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 03:06:47 -0500
Date: Tue, 31 Oct 2006 08:59:40 +0100 (CET)
To: multinymous@gmail.com, davidz@redhat.com
Subject: Re: [PATCH v2] Re: Battery class driver.
X-IlohaMail-Blah: khali@localhost
X-IlohaMail-Method: mail() [mem]
X-IlohaMail-Dummy: moo
X-Mailer: IlohaMail/0.8.14 (On: webmail.gcu.info)
Message-ID: <6DP6m926.1162281579.9733640.khali@localhost>
In-Reply-To: <41840b750610281112q7790ecao774b3d1b375aca9b@mail.gmail.com>
From: "Jean Delvare" <khali@linux-fr.org>
Bounce-To: "Jean Delvare" <khali@linux-fr.org>
CC: "Richard Hughes" <hughsient@gmail.com>,
       "David Woodhouse" <dwmw2@infradead.org>,
       "Dan Williams" <dcbw@redhat.com>, linux-kernel@vger.kernel.org,
       devel@laptop.org, sfr@canb.auug.org.au, len.brown@intel.com,
       greg@kroah.com, benh@kernel.crashing.org,
       "linux-thinkpad mailing list" <linux-thinkpad@linux-thinkpad.org>,
       "Pavel Machek" <pavel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/28/2006, an anonymous coward wrote:
>On 10/28/06, David Zeuthen <davidz@redhat.com> wrote:
>> What about just prepending the unit to the 'threshold' file? Then user
>> space can expect the contents of said file to be of the form "%d %s". I
>> don't think that violates the "only one value per file" sysfs mantra.
>
>The tp_smapi battery driver did just this  ("16495 mW"). But I dropped
>it in a recent version when Pavel pointed out the rest of sysfs, hwmon
>included, uses undecorated integers.
>Consistency aside, it seems reasonable and convenient. You have to
>decree that writes to the attributes (where relevant) don't include
>the units, of course, so no one will expect the kernel to parse that.

But what value should then be written? One in an absolute aribtrary unit?
That would make reads and writes to the sysfs files inconsistent, in
direct violation of the sysfs standard. Or in the same unit read from
the file? It means that userspace must first read from the file, parse
the unit, then convert the value to be written. This doesn't match my
definition of "convenient".

>There's an issue here if a drunk driver decides to specify (say)
>capacity_remaining in mWh and capacity_last_full in mAa, which will
>confuse anyone comparing those attributest. So don't do that.
>
>Jean, what's your opinion on letting hwmon-ish attributes specify
>units as "%d %s" where these are hardware-dependent?

I fail to see any benefit in doing so, while I see several problems (see
above) and potential for confusion. So my opinion is: please don't do
that.

Thanks,
--
Jean
