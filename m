Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751964AbWG0Tcj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751964AbWG0Tcj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 15:32:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751046AbWG0Tcj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 15:32:39 -0400
Received: from host36-195-149-62.serverdedicati.aruba.it ([62.149.195.36]:19093
	"EHLO mx.cpushare.com") by vger.kernel.org with ESMTP
	id S1751960AbWG0Tci (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 15:32:38 -0400
Date: Thu, 27 Jul 2006 21:34:06 +0200
From: andrea@cpushare.com
To: Luigi Genoni <genoni@sns.it>, "Horst H. von Brand" <vonbrand@inf.utfsm.cl>,
       Adrian Bunk <bunk@stusta.de>, "J. Bruce Fields" <bfields@fieldses.org>,
       Hans Reiser <reiser@namesys.com>, Nikita Danilov <nikita@clusterfs.com>,
       Rene Rebe <rene@exactcode.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: the ' 'official' point of view' expressed by kernelnewbies.org regarding reiser4 inclusion
Message-ID: <20060727193406.GH6877@opteron.random>
References: <genoni@sns.it> <2870.192.167.206.189.1153998447.squirrel@darkstar.linuxpratico.net> <200607271330.k6RDUaPC008087@laptop13.inf.utfsm.cl> <4095.192.167.206.189.1154010667.squirrel@darkstar.linuxpratico.net> <20060727183733.GA21439@voodoo.jdc.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060727183733.GA21439@voodoo.jdc.home>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2006 at 02:37:33PM -0400, Jim Crilly wrote:
> Or because they did 'allmodconfig' or 'allyesconfig'. Whenever I build
> a kernel I enabled everything possible as a module in case I ever need
> it. For instance, a few weeks ago I had the reiserfs module loaded because
> I was testing something, if I had klive running it would have said that I
> use reiserfs when in fact I don't.

reiserfs would showup in the module list in such case, but _not_ in
the fs list. KLive records both the modules loaded _and_ the mounted
fs.

This is the code that records the FS:

	if CONFIG_FS:
		fs = {}
		for _fs in [ re.search(r'^[^\s]+\s[^\s]+\s([^\s]+)', x).group(1)
			     for x in file('/proc/mounts').readlines() ]:
			if _fs not in ['rootfs', 'proc', 'devpts']:
				fs[_fs] = None
		fs = ' '.join(fs.keys())
		KERNEL += str_append(fs)

/proc/mounts only lists the _mounted_ fs, not the fs loaded into the
kernel statically or with insmod.
