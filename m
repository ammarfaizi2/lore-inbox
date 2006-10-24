Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751990AbWJXDEU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751990AbWJXDEU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 23:04:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752006AbWJXDEU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 23:04:20 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:30929 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751990AbWJXDET (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 23:04:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oJIT1v5O7jPYqOrfvBwxA/rLfBOTmiJ9Gr8MaQsEvV39EImP0Vz63z2hWlsl5Cg9iudJdyEiZ5bce94blYka5rmjKlnK80DW1KPI7Xh6Eq5h4yjT76hJ8tLdo3V+JNrSbwpISOWkU+qtCiCgr531xYhDx78W/HrjFAHMCmeHHms=
Message-ID: <41840b750610232004k46e4937emfcdff4f1aef0b30f@mail.gmail.com>
Date: Tue, 24 Oct 2006 05:04:17 +0200
From: "Shem Multinymous" <multinymous@gmail.com>
To: "David Zeuthen" <davidz@redhat.com>
Subject: Re: Battery class driver.
Cc: "Greg KH" <greg@kroah.com>, "David Woodhouse" <dwmw2@infradead.org>,
       linux-kernel@vger.kernel.org, olpc-dev@laptop.org, mjg59@srcf.ucam.org,
       len.brown@intel.com, sfr@canb.auug.org.au, benh@kernel.crashing.org
In-Reply-To: <1161653469.2801.91.camel@zelda.fubar.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1161627633.19446.387.camel@pmac.infradead.org>
	 <1161641703.2597.115.camel@zelda.fubar.dk>
	 <20061023225905.GA10977@kroah.com>
	 <1161653469.2801.91.camel@zelda.fubar.dk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/24/06, David Zeuthen <davidz@redhat.com> wrote:

>  b) if the kernel ensures that the 'timestamp' file is updated last,
>     we get atomic updates

Atomic updates require either double-buffering the data (twice worse
than mere caching...) or locking away access during update (in which
case the order doesn't mater).

But yes, lack of atomicity in sysfs is a big issue. We don't seem to
have any ABI convention for providing atomic snapshots of those
dozen-small-atribute directories.


>     Notably user space can see _when_ the values from the hardware was
>     retrieved the last time


> This is a good thing, but is orthogonal to the how-do-we-poll issue.


> So.. how all this relates to hwmon I'm not sure.. looking briefly at
> Documentation/hwmon/sysfs-interface no such thing seems to be available,

Yes, hwmon ignores merrily ignores this issue, as do all other
data-through-sysfs drivers I've looked at. Except for the patched
hdaps driver in the tp_smapi package, which has a (very) rudimentary
solution via caching and a configurable in-kernel polling timer.

  Shem
