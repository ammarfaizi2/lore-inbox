Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261253AbVAGBp5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261253AbVAGBp5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 20:45:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261302AbVAGBmj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 20:42:39 -0500
Received: from [220.248.27.114] ([220.248.27.114]:61673 "HELO soulinfo.com")
	by vger.kernel.org with SMTP id S261253AbVAGBkv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 20:40:51 -0500
Date: Fri, 7 Jan 2005 09:40:23 +0800
From: hugang@soulinfo.com
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [hugang@soulinfo.com: [PATH]software suspend for ppc.]
Message-ID: <20050107014023.GA29740@hugang.soulinfo.com>
References: <20050103122653.GB8827@hugang.soulinfo.com> <20050103221718.GC25250@elf.ucw.cz> <20050106160306.GA20127@hugang.soulinfo.com> <20050106223132.GD25913@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="AqsLC8rIMeq19msA"
Content-Disposition: inline
In-Reply-To: <20050106223132.GD25913@elf.ucw.cz>
User-Agent: Mutt/1.3.28i
X-Virus-Checked: Checked
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 06, 2005 at 11:31:32PM +0100, Pavel Machek wrote:
> Hi!
> 
> > adding a option to freeze/thaw_processes, first freeze all user
> > processess, from now only kernel processess running, Now we can shrink
> > more memory than current version, after that freeze all processes.
> > that's mean if your swap space enough, swsusp will not fail. 
> 
> Thanks for the port... ...what is the test case this fixes?
> 
> Patch is pretty pretty simple, that's good...

# free
....
Mem:        256368     198148
...
Swap:       524280     140108

# ./eatmem 256

now do swsusp, the current swsusp will fail, with the patch it works.


-- 
Hu Gang       .-.
              /v\
             // \\ 
Linux User  /(   )\  [204016]
GPG Key ID   ^^-^^   http://soulinfo.com/~hugang/hugang.asc

--AqsLC8rIMeq19msA
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="eatmem.c"

#include <stdio.h>

static int
do_malloc(int size)
{
	char *p;
	int i;

	for (i = 0; i < size; i++) {
		p = malloc(1024 * 1024);
		if (p == NULL) return -1;
		memset(p, 1, 1024 * 1024);
		printf("%2d\r", i);
		fflush(stdout);
	}
	return (0);
}

int 
main(int argc, char *argv[])
{
	int size = 200;

	if (argc == 2) {
		size = atoi(argv[1]);
	}

	do_malloc(size);

	pause();
}

--AqsLC8rIMeq19msA--
