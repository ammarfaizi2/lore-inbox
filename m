Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285167AbRLMUso>; Thu, 13 Dec 2001 15:48:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285166AbRLMUsf>; Thu, 13 Dec 2001 15:48:35 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:59915 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S285179AbRLMUsW>; Thu, 13 Dec 2001 15:48:22 -0500
Message-ID: <3C1913C5.30701@namesys.com>
Date: Thu, 13 Dec 2001 23:47:01 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: Andrew Pimlott <andrew@pimlott.ne.mediaone.net>
CC: Anton Altaparmakov <aia21@cam.ac.uk>, Nathan Scott <nathans@sgi.com>,
        Andreas Gruenbacher <ag@bestbits.at>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: reiser4 (was Re: [PATCH] Revised extended attributes  interface)
In-Reply-To: <20011205143209.C44610@wobbly.melbourne.sgi.com> <20011207202036.J2274@redhat.com> <20011208155841.A56289@wobbly.melbourne.sgi.com> <3C127551.90305@namesys.com> <20011211134213.G70201@wobbly.melbourne.sgi.com> <5.1.0.14.2.20011211184721.04adc9d0@pop.cus.cam.ac.uk> <3C1678ED.8090805@namesys.com> <20011212204333.A4017@pimlott.ne.mediaone.net> <3C1873A2.1060702@namesys.com> <20011213102729.B3812@pimlott.ne.mediaone.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Pimlott wrote:

>On Thu, Dec 13, 2001 at 12:23:46PM +0300, Hans Reiser wrote:
>
>>Andrew Pimlott wrote:
>>
>>>First, I write a desktop application that wants to save an HTML file
>>>along with some other object that contains the name of the creating
>>>application.  The latter can go anywhere you want, except in the
>>>same stream as the HTML file.  The user has requested that the
>>>filename be /home/user/foo.html , and expects to be able to FTP this
>>>file to his ISP with a standard FTP program.  What calls does my
>>>application make to store the HTML and the application name?  If the
>>>answer is different depending on whether /home/user is NTFS or
>>>reiserfs4, explain both ways.
>>>
>>Are you sure that standard ftp will be able to handle extended 
>>attributes without modification?
>>
>
>No, the ftp program only needs to transfer the HTML part.
>
>>One approach is to create a plugin called ..archive that when read is a 
>>virtual file consisting of an archive of everything in the directory. 
>>
>
>Ok, does this mean that every directory in the filesystem (or in
>some part of it) will automatically have a node ..archive?
>Presumably, it will not appear in directory listings, but can be
>read but not written to?  Does this mean that a legacy application
>(pathological as it may be) that expects to be able to create a file
>called ..archive will fail?
>
I remember that I used to be a sysadmin with some NetApp boxes that have 
a .snapshot directory that is invisible, and has special qualities.

It worked.  There were no namespace collision problems.  None.

These things can be survived by users.;-)

Nothing I say should be construed to mean that I think that a particular 
name for a pseudo-file implemented by the default regular directory 
plugin is what should ship.  I am easy in such matters.  You can also 
get me to agree it should be modifiable, so that if Joe Sevenpack needs 
a file named ..archive, he can have it.

>
>
>Or do you mean that the application would explicitly create the node
>associated with this plugin?
>
Both.  If you want a file named '..glob' that does the same thing as
'..archive', go for it.  I am not necessarily committed to putting 
..archive in the default directory plugin (actually, I don't like that 
name, it should be something snappier, but I haven't thought of it).  I 
also am not funded to implement ..archive at the moment (I am funded to 
do inheritance though) .

>
>
>>It would be interesting I think to attach said plugin to standard 
>>directories by default along with several other standard plugins like 
>>..cat, etc.
>>
>
>Anyway, you didn't answer the part I really care about.  What calls
>does the application make to store the HTML and the "extended
>attribute"?  You can pick whatever conventions you want, just give
>me an example.
>

read, write, etc., on file.html/..joes_attribute, unless it is a 
particular attribute that has particular effects on the particular 
plugin for file.html, in which case it all depends on the plugin and the 
constraints imposed on joes_attribute.  It may be that modifying 
file.html modifies ..joes_attribute as a side-effect, plugins can do 
anything in response to a VFS operation.  You put the plugin into your 
kernel, you'd better be able to trust it....

>
>
>>>Second, I booted NT and created a directory in the NTFS filesystem
>>>called /foo .  In the directory, I created a file called bar.  I
>>>also created a named stream called bar, and an extended attribute
>>>called bar.  Now I boot Linux.  What calls do I make to see each of
>>>the three objects called bar?
>>>
>>You access /foo/bar, /foo/bar/,,bar, /foo/..bar by name.
>>
>
>How do I access the file called ..bar (created in NT) in the
>directory /foo?
>

If you have permission, you can:
cat /foo/..bar

Or you can use the efficient for small files API we are implementing, 
which I won't go into here.

>
>
>(Anton, does NTFS define any reserved filename characters, or only
>win32?)
>
>Andrew
>
>



