Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261497AbVDDXOP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261497AbVDDXOP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 19:14:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261479AbVDDXLw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 19:11:52 -0400
Received: from baikonur.stro.at ([213.239.196.228]:42648 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S261465AbVDDXGQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 19:06:16 -0400
Date: Tue, 5 Apr 2005 01:05:43 +0200
From: maximilian attems <janitor@sternwelten.at>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>,
       B.Zolnierkiewicz@elka.pw.edu.pl, rusty@rustcorp.com.au
Subject: Re: [patch 2/3] hd eliminate bad section references
Message-ID: <20050404230543.GA14823@sputnik.stro.at>
References: <20050404181102.GB12394@sputnik.stro.at> <4251BBC5.8000802@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4251BBC5.8000802@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 04 Apr 2005, Randy.Dunlap wrote:

> >-static int parse_hd_setup (char *line) {
> >+static int __init parse_hd_setup (char *line) {
.. 
> This one is fairly interesting and needs some resolution by someone
> who knows....

thanks a lot for your quick and profund feedback.
 
> On the surface, the patch is correct.
> 
> Rusty, can you explain when __setup functions are called relative
> to in-kernel init functions?  or put another way, can a __setup
> function safely call in __init function?
> 
> Here's the function in question:
> 
> static int parse_hd_setup (char *line) {
> 	int ints[6];
> 
> 	(void) get_options(line, ARRAY_SIZE(ints), ints);
> 	hd_setup(NULL, ints);
> 
> 	return 1;
> }
> __setup("hd=", parse_hd_setup);
> 
> 
> 
> Should we make parse_hd_setup() __init,
> or make hd_setup() non-__init, or something else?
> 
> {time passes, he looks]
> 
> OK, I looked at include/linux/init.h.  From what I can see
> there, __setup() causes an .init.setup section to be emitted,
> so marking __setup() function as __init would make sense.
> I think that this patch is good.

i saw that ide_setup() is __init as a bunch of lots others.
yes init.h confirms that. :)

--
maks
kernel janitor  	http://janitor.kernelnewbies.org/

