Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161011AbWBYPf5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161011AbWBYPf5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 10:35:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161014AbWBYPf5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 10:35:57 -0500
Received: from wproxy.gmail.com ([64.233.184.195]:64834 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161011AbWBYPf4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 10:35:56 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oT6u9SHPNu+8Rm8crEqrtPqogBV1EPGUTvsswstJu0yTxya+2n4FMSQ3GnTcwOTkDNSsGPcHjKTRErRPJOM5XKaYzfyzmcf/FDRqp5CsdIaNgBKAsGbxGVbysRZObhL8YF4qLNHuVjUQErh2Z+N7+Ca2RHKA8E3O+rt2HEkn17g=
Message-ID: <9a8748490602250735l6161a96dte2805b772a89a436@mail.gmail.com>
Date: Sat, 25 Feb 2006 16:35:55 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Maciej Soltysiak" <solt2@dns.toxicfilms.tv>
Subject: Re: creating live virtual files by concatenation
Cc: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
In-Reply-To: <1271316508.20060225153749@dns.toxicfilms.tv>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1271316508.20060225153749@dns.toxicfilms.tv>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/25/06, Maciej Soltysiak <solt2@dns.toxicfilms.tv> wrote:
> Hello!
>
> I have this idea about creating sort of a virtual file.
>
> Let us say I have three text files that contain javascript code:
> tooltip.js
> banner.js
> foo.js
>
> Now let us say I am creating sort of a virtual text file (code.js)
> that is a live-concatenation of these files:
> # concatenate tooltip.js banner.js foo.js code.js
>
> Note I am not talking about the cat(1) utility. I am thinking of
> code.js be always a live concatenated version of these three, so when
> I modify one file, the live-version is also modified.
>
> What puprose I might have? Network-related. Say, I have an HTML file
> that includes these three files in its code.
>
> When a browser downloads the HTML file it will then create three threads
> to download each of those javascript files.
>
> If I had a live-concatenated file, I could reference it in the HTML file
> so that the browser does not have to download three files but just one.
>

If that's what you want to accomplish, then you can easily get around
that in several ways.

1. Simply   $ cat tooltip.js banner.js foo.js > code.js  then include
code.js in your html document and remember to update it when you
change one of the 3 files (or create a script that does it.

2. use Apache's mod_include

3. Use PHP, Perl, python or watever your scripting language of choice
is - here's an example in PHP :

<?php
header('Content-type: text/javascript');
readfile('tooltip.js');
readfile('banner.js');
readfile('foo.js');
?>

save that as javascripts.php then put this in your HTML document :

<script src="javascripts.php" language="javascript"
type="text/javascript"></script>


And there are other ways ...


> This would surely reduce network overhead of downloading the same amount
> of data but within just one connection, reduce resource usage on the client
> and possibly (depending on implementation) reduce the cost of accessing
> three individual files on the server.
>

Negligible I'd say.


> I am CC'ing reiserfs-list because Reiser4 would seem to be the most
> robust filesystem that could have it done.
>
> Any thoughts about the idea itself?

Might be a cute little hack, but I don't think it's a very useful
feature really..


> Would be nice if this idea could inspire some talented hackers here and there.
>
> Best Regards,
> Maciej
>


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
