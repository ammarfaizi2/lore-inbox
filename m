Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262054AbVCCSUb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262054AbVCCSUb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 13:20:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262580AbVCCSTB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 13:19:01 -0500
Received: from locomotive.csh.rit.edu ([129.21.60.149]:9762 "EHLO
	locomotive.unixthugs.org") by vger.kernel.org with ESMTP
	id S262588AbVCCSQz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 13:16:55 -0500
Message-ID: <42275536.8060507@suse.com>
Date: Thu, 03 Mar 2005 13:19:34 -0500
From: Jeff Mahoney <jeffm@suse.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] openfirmware: adds sysfs nodes for openfirmware	devices
References: <20050301211824.GC16465@locomotive.unixthugs.org> <1109806334.5611.121.camel@gaston>
In-Reply-To: <1109806334.5611.121.camel@gaston>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Bogosity: No, tests=bogofilter, spamicity=0.000000, version=0.92.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Benjamin Herrenschmidt wrote:
> On Tue, 2005-03-01 at 16:18 -0500, Jeffrey Mahoney wrote:
> 
>>This patch adds sysfs nodes that the hotplug userspace can use to load the
>>appropriate modules.
>>
>>In order for hotplug to work with macio devices, patches to module-init-tools
>>and hotplug must be applied. Those patches are available at:
>>
>>ftp://ftp.suse.com/pub/people/jeffm/linux/macio-hotplug/
>>
>>Signed-off-by: Jeff Mahoney <jeffm@suse.com>
> 
> 
>>+static ssize_t
>>+compatible_show (struct device *dev, char *buf)        
>>+{
>>+        struct of_device *of;
>>+        char *compat;
>>+        int cplen;
>>+        int length = 0;
>>+        
>>+        of = &to_macio_device (dev)->ofdev;
>>+	compat = (char *) get_property(of->node, "compatible", &cplen);
>>+	if (!compat) {
>>+		*buf = '\0';
>>+		return 0;
>>+	}
>>+	while (cplen > 0) {
>>+		int l;
>>+		length += sprintf (buf, "%s%s", length ? "," : "", compat);
>>+		buf += length;
>>+		l = strlen (compat) + 1;
>>+		compat += l;
>>+		cplen -= l;
>>+	}
>>+
>>+	return length;
>>+}
>>+
> 
> 
> There is a problem here. "," is a valid character within a "compatible"
> property, and is actually regulary used. Normally, "compatible" is a
> list, with '\0' beeing the separator. I suggest using CRLF instead.

Reviewing the 'compatible' values in my device-tree, I definately agree.
I can hack the pmac_zilog driver to test this out further - I've just
been using my airport card.

Are there any other "invalid" characters for the compatible property?
CRLF would work, but these values (as a group) need to be put into
modules.ofmap as well as passed via environment variables for hotplug.
As such, CRLF isn't really easiest choice to work with.

Is whitespace (in any form) allowed in the compatible value?

- -Jeff

- --
Jeff Mahoney
SuSE Labs
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCJ1U2LPWxlyuTD7IRAopmAJ44hoUKoCrhdBSyAnCp+jzSauAZ8gCfXt7k
tSZa3KiwEybqOoVhPHsQ5Lg=
=9Cvt
-----END PGP SIGNATURE-----
