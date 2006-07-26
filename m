Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030283AbWGZAKK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030283AbWGZAKK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 20:10:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030285AbWGZAKK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 20:10:10 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:4521 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1030283AbWGZAKJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 20:10:09 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <44C6B269.4080607@s5r6.in-berlin.de>
Date: Wed, 26 Jul 2006 02:08:09 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040914
X-Accept-Language: de, en
MIME-Version: 1.0
To: James Courtier-Dutton <James@superbug.co.uk>
CC: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: [RFC PATCH] Multi-threaded device probing
References: <20060725203028.GA1270@kroah.com> <44C69819.8080908@superbug.co.uk>
In-Reply-To: <44C69819.8080908@superbug.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Courtier-Dutton wrote:
> What happens about the logging?
> Surely one would want the output from one probe to be output into the
> log as a block, and not mix the output from multiple simultaneous probes.

Use single-line printks were possible, or mutex-protected multiline 
blocks where you really can't do without multiple lines of printks that 
really cannot be separated. (Don't perform time consuming functions 
within those mutexes; that would defeat the multithreaded probing...)

To adjust printks is only the beginning of what is to be done to adapt 
single-threaded bus probes to multithreaded ones. There may be hidden 
assumptions that rely on single-threaded execution.
-- 
Stefan Richter
-=====-=-==- -=== ==-=-
http://arcgraph.de/sr/
