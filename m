Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129351AbQK1QJN>; Tue, 28 Nov 2000 11:09:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129383AbQK1QJD>; Tue, 28 Nov 2000 11:09:03 -0500
Received: from 213-123-72-140.btconnect.com ([213.123.72.140]:58886 "EHLO
        penguin.homenet") by vger.kernel.org with ESMTP id <S129351AbQK1QIt>;
        Tue, 28 Nov 2000 11:08:49 -0500
Date: Tue, 28 Nov 2000 15:40:39 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: "David S. Miller" <davem@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: bug in count_open_files() or a strange granularity?
In-Reply-To: <200011281506.HAA02318@pizda.ninka.net>
Message-ID: <Pine.LNX.4.21.0011281539000.1254-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Nov 2000, David S. Miller wrote:
> What you want is something like:
> 
> static int num_open_files(struct files_struct *files, int size)
> {
> 	total = 0;
> 	for (i = size / (8 * sizeof(long)); i > 0; )
> 		total += count_bits(files->open_fds->fds_bits[--i]);
> 
> 	return total;
> }

Ok, since we have to walk the sets and test the bits anyway, I propose to
make close_files() to return 'nr_open_fds' and accept an extra argument
'doclose=0 or 1' which will specify whether we want to close the 'fd' or
whether we just want to count them.

Regards,
Tigran

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
