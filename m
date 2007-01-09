Return-Path: <linux-kernel-owner+w=401wt.eu-S1750850AbXAIBJX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750850AbXAIBJX (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 20:09:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750849AbXAIBJX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 20:09:23 -0500
Received: from mail9.hitachi.co.jp ([133.145.228.44]:50086 "EHLO
	mail9.hitachi.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750793AbXAIBJW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 20:09:22 -0500
Message-ID: <45A2EADF.3030807@hitachi.com>
Date: Tue, 09 Jan 2007 10:07:43 +0900
From: "Kawai, Hidehiro" <hidehiro.kawai.ez@hitachi.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; ja-JP; rv:1.4) 
    Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: ja
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       gregkh@suse.de, james.bottomley@steeleye.com,
       Satoshi OSHIMA <soshima@redhat.com>,
       "Hideo AOKI@redhat" <haoki@redhat.com>,
       sugita <yumiko.sugita.yf@hitachi.com>,
       Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] binfmt_elf: core dump masking support
References: <457FA840.5000107@hitachi.com> 
    <20061213132358.ddcaaaf4.akpm@osdl.org> <20061220154056.GA4261@ucw.cz>
In-Reply-To: <20061220154056.GA4261@ucw.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Pavel

Pavel Machek wrote:

> > When a new process is created, the process inherits the coremask
> > setting from its parent. It is useful to set the coremask before
> > the program runs. For example:
> > 
> >   $ echo 1 > /proc/self/coremask
> >   $ ./some_program
>
> User can already ulimit -c 0 on himself, perhaps we want to use same
> interface here? ulimit -cmask=(bitmask)?

Are you saying that 1) it is good to change ulimit (shell programs)
so that shell programs will read/write /proc/self/coremask when
the -cmask option is given to ulimit?
Or, 2) it is good to change ulimit and get/setrlimit so that shell
programs will invoke get/setrlimit with new parameter?

If the changes are acceptable to bash or other shell community, I think
the first approach is nice.
But the second approach is problematic because the bitmask doesn't
conform to the usage of setrlimit.  You know, setrlimit controls amount
of resources the system can use by the soft limit and hard limit.
These limitations don't suit for the bitmask.


By the way, the /proc/<pid>/coremask method has an advantage over the
ulimit method.  It allows system administrator to change the bitmask of
any process anytime.
That's why I decided to use the /proc/<pid>/ interface.

Best regards,
--
Hidehiro Kawai
Hitachi, Ltd., Systems Development Laboratory


