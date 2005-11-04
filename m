Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932731AbVKDMwZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932731AbVKDMwZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 07:52:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932734AbVKDMwZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 07:52:25 -0500
Received: from mail.fh-wedel.de ([213.39.232.198]:46037 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S932731AbVKDMwZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 07:52:25 -0500
Date: Fri, 4 Nov 2005 13:52:21 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: jblunck@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC,PATCH] libfs dcache_readdir() and dcache_dir_lseek() bugfix
Message-ID: <20051104125221.GA18718@wohnheim.fh-wedel.de>
References: <20051104113851.GA4770@hasse.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20051104113851.GA4770@hasse.suse.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 November 2005 12:38:51 +0100, jblunck@suse.de wrote:

> #include <stdio.h>
> #include <unistd.h>
> #include <dirent.h>
> 
> int main(int argc, char *argv[])
> {
> 	DIR *dir;
> 	struct dirent *entry;
> 	unsigned int offset;
> 
>         if (argc < 2) {
>                 printf("USAGE:  %s <directory>\n", argv[0]);
>                 return 1;
>         }
> 
> 	dir = opendir(argv[1]);
> 	if (!dir)
> 		return 1;
> 
> 	while((entry = readdir(dir)) != NULL) {
> 		seekdir(dir, entry->d_off);
> 		printf("name=%s\tino=%d off=%d\n", entry->d_name, entry->d_ino,
> 		       entry->d_off);
> 		if (*entry->d_name == '.')
> 			continue;

That catches "." and "..", but also ".foo".  Doesn't matter for the
test, just wanted to mention it.

> 		if(unlink(entry->d_name) != 0)
> 			break;
> 	}
> 
> 	closedir(dir);
> 	return 0;
> }


Jörn

-- 
With a PC, I always felt limited by the software available. On Unix, 
I am limited only by my knowledge.
-- Peter J. Schoenster
