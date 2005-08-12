Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750814AbVHLImx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750814AbVHLImx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 04:42:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750709AbVHLImw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 04:42:52 -0400
Received: from dgate1.fujitsu-siemens.com ([217.115.66.35]:43886 "EHLO
	dgate1.fujitsu-siemens.com") by vger.kernel.org with ESMTP
	id S1750814AbVHLImw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 04:42:52 -0400
X-SBRSScore: None
X-IronPort-AV: i="3.96,102,1122847200"; 
   d="scan'208"; a="13979607:sNHT28659232"
Message-ID: <42FC6104.6070200@fujitsu-siemens.com>
Date: Fri, 12 Aug 2005 10:42:44 +0200
From: Martin Wilck <martin.wilck@fujitsu-siemens.com>
Organization: Fujitsu Siemens Computers
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: de, en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
Cc: Alexander Nyberg <alexn@telia.com>, linux-kernel@vger.kernel.org
Subject: Re: files_lock deadlock?
References: <42DD2E37.3080204@fujitsu-siemens.com>	 <1121870871.1103.14.camel@localhost.localdomain>	 <42FB8ECF.4090106@fujitsu-siemens.com>	 <1123782699.3201.43.camel@laptopd505.fenrus.org>	 <42FC448F.6070702@fujitsu-siemens.com> <1123830453.3218.0.camel@laptopd505.fenrus.org>
In-Reply-To: <1123830453.3218.0.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:

> doing anything with files implies having a defined usercontext really,
> and generally sleeping as well. So think this is quite safe.

Looking closer at this, I'd say that files_lock should be replaced by 
locking of the respective lists (struct sb->s_files and struct 
tty_struct->tty_files, unless I'm mistaken),  and that this locking 
should be done with semaphores. Right?

Going through the list of all sb->s_files can be a costly operation; it 
may be worthwile to have a per-sb locking mechanism for that.

Martin

-- 
Martin Wilck                Phone: +49 5251 8 15113
Fujitsu Siemens Computers   Fax:   +49 5251 8 20409
Heinz-Nixdorf-Ring 1        mailto:Martin.Wilck@Fujitsu-Siemens.com
D-33106 Paderborn           http://www.fujitsu-siemens.com/primergy
