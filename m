Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129598AbRDBPGJ>; Mon, 2 Apr 2001 11:06:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129618AbRDBPF7>; Mon, 2 Apr 2001 11:05:59 -0400
Received: from tomts8.bellnexxia.net ([209.226.175.52]:59865 "EHLO
	tomts8-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S129598AbRDBPFt>; Mon, 2 Apr 2001 11:05:49 -0400
Message-ID: <3AC89389.46317572@coplanar.net>
Date: Mon, 02 Apr 2001 10:58:17 -0400
From: Jeremy Jackson <jerj@coplanar.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Ian Soboroff <ian@cs.umbc.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: /proc/config idea
In-Reply-To: <877l13whzw.fsf@danube.cs.umbc.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian Soboroff wrote:

> [sorry this doesn't have proper References: headers, i read the list
> off the hypermail archive.]
>
> there was some discussion of whether the kernel should emit a
> /proc/config or some such for purposes of bug reporting, but that
> seems to be a lot of bloat.
>
> instead, why not try to point to a canonical location for a config
> copy (we already basically do this with ksymoops and System.map), and
> instead have a /proc/config-hash which emits a (precomputed) MD5 hash
> of the .config file it was compiled with?
>
> this way, you could check possible configs (Debian for example likes
> to stash a copy in /boot, like System.map) and also know if they were

Yes, I like this.  I do this manually, it allows reproducability, and
incremental
modifications, tracing how that kernel on that problem system was made...

I think the ultimate would be to put all of .config (gzipped?) in a new ELF
section without the Loadable attribute...  I wish System.map was the same.
The you're guaranteed you know how a kernel on disk was configured.

To correlate a running kernel to one on disk (vmlinuz) you have LILO...
it appends an environment variable to the kernel command line with
the name of the file it booted.  This is not infallable, since LILO maps
disk sectors, only using the filesystem at map install time.

Permaps an md5sum of the .text ELF section would conclusively
link the in-core kernel with an on-disk vmlinuz?  Shouldn't be hard
to do with objcopy and /proc/kmem?

>
> the right ones.
>
> the one problem that comes to mind right now is modules, which needn't
> correspond to a full kernel .config.

Well it's a step...

Comments anyone?


