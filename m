Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262855AbSJGDur>; Sun, 6 Oct 2002 23:50:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262859AbSJGDur>; Sun, 6 Oct 2002 23:50:47 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:52442 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S262855AbSJGDuq>;
	Sun, 6 Oct 2002 23:50:46 -0400
Date: Sun, 6 Oct 2002 23:56:20 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
cc: "David S. Miller" <davem@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BKPATCH] X25: use seq_file for proc stuff
In-Reply-To: <20021007033155.GB1201@conectiva.com.br>
Message-ID: <Pine.GSO.4.21.0210062351380.29030-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 7 Oct 2002, Arnaldo Carvalho de Melo wrote:

> +static struct file_operations x25_seq_socket_fops = {
> +	.open		= x25_seq_socket_open,
> +	.read		= seq_read,
> +	.llseek		= seq_lseek,
> +	.release	= seq_release,
> +};
> +
> +static struct file_operations x25_seq_route_fops = {
> +	.open		= x25_seq_route_open,
> +	.read		= seq_read,
> +	.llseek		= seq_lseek,
> +	.release	= seq_release,
> +};
> +
> +static int x25_proc_perms(struct inode* inode, int op)
> +{
> +	return 0;
> +}
> +
> +static struct inode_operations x25_seq_inode = {
> +	.permission	= x25_proc_perms,
> +};

> +	p = create_proc_entry("route", 0, x25_proc_dir);
> +	if (!p)
> +		goto out_route;
> +	p->proc_fops = &x25_seq_route_fops;
> +	p->proc_iops = &x25_seq_inode;
> +
> +	p = create_proc_entry("socket", 0, x25_proc_dir);
> +	if (!p)
> +		goto out_socket;
> +	p->proc_fops = &x25_seq_socket_fops;
> +	p->proc_iops = &x25_seq_inode;

Huh???

a) ->permission() always returning 0 on a read-only file is... interesting.
b) if you want it world-readable, kernel is perfectly capable of doing that;
had been since the very beginning.  Just set mode to 0444 and be done with
that; no need to have anything special in ->proc_iops.

