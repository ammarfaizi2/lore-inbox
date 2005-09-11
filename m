Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751044AbVIKPhr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751044AbVIKPhr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 11:37:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751034AbVIKPhr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 11:37:47 -0400
Received: from smtp.ctyme.com ([209.237.228.12]:57218 "EHLO darwin.ctyme.com")
	by vger.kernel.org with ESMTP id S1750723AbVIKPhq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 11:37:46 -0400
Message-ID: <43244F46.70500@perkel.com>
Date: Sun, 11 Sep 2005 08:37:42 -0700
From: Marc Perkel <marc@perkel.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.10) Gecko/20050716
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Very strange ACL problem
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-filter-host: darwin.ctyme.com - http://www.junkemailfilter.com
X-Sender-host-address: 204.95.16.61
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello - I'm new to this list so if I'm in the wrong place let me know. 
But I think I've discovered a very strange ACL problem that I'd like to 
report. I'm still investigating the details of it but I believe it's a 
bug in the kernel.

First -I'm running Fedora Core 4 on a dual Athlon 64. i'm running a 
custom compiled 2.6.13 kernel compiled for 64 bit. File system is EXT3. 
SELinux is disabled.

This is going to look like an end user issue - but it's not - so please 
read the whole message.

Here is the problem. When running a PHP sctript from Apache (phpBB) I 
get this error.

Template->make_filename(): Error - file /overall_header.tpl does not exist

Looks like a permissions problem at first but after setting everything 
to 777 I still get the same error - but - if I edit the file 
/www/sfparkingtickets/phpBB2/includes/template.php with pico - make no 
change by just do a save rewriting the same file - everything works - 
that is until I reboot.

Somehow the act of rewriting the file unlocks some permissions somewhere 
and things start to work.

Also - even though permissions are 777 - if I chmod them to 777 I get 
the error. If I chown to apache - even though the file is already owned 
by apache - I get the error. But in all cases if I edit the file with 
pico and making no changes rewrite the file - it starts to work again.

I also just tried removing all acl permissions with setfacl -R -b and 
that doesn't affect it. So it might not be ACL related necessarilly.

I just tried appending a blank line to the end of the file with echo "" 
 >> template.php and like pico - it clears the error.

In summary - changing permission or owner - even though I'm setting it 
to the same thing - causes the problem every time. Writing to the file 
in any way - even if you don't change the file - clears the error. So it 
looks to me like there is some bug in the permissions logic.

-- 
Marc Perkel - marc@perkel.com

Spam Filter: http://www.junkemailfilter.com
    My Blog: http://marc.perkel.com

