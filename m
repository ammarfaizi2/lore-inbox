Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315111AbSEHUV4>; Wed, 8 May 2002 16:21:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315115AbSEHUVz>; Wed, 8 May 2002 16:21:55 -0400
Received: from w007.z208177138.sjc-ca.dsl.cnc.net ([208.177.141.7]:61331 "HELO
	mail.gurulabs.com") by vger.kernel.org with SMTP id <S315111AbSEHUVx>;
	Wed, 8 May 2002 16:21:53 -0400
Date: Wed, 8 May 2002 14:21:51 -0600 (MDT)
From: Dax Kelson <dax@gurulabs.com>
X-X-Sender: dkelson@mooru.gurulabs.com
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
cc: "torvalds@transmeta.com" <torvalds@transmeta.com>,
        "alan@lxorguk.ukuu.org.uk" <alan@lxorguk.ukuu.org.uk>,
        "marcelo@conectiva.com.br" <marcelo@conectiva.com.br>
Subject: [RFC] Making capabilites useful with legacy apps
In-Reply-To: <Pine.LNX.4.33.0205082029060.14553-100000@sphinx.mythic-beasts.com>
Message-ID: <Pine.LNX.4.44.0205081403120.10496-100000@mooru.gurulabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In attempt to make capabilites more useful before the filesytem support 
arrives, I would like to "wrap" non-capabilities aware apps.

For example:

# capwrap --user nobody --grp nobody --cap CAP_NET_BIND_SERVICE nc -l -p 80

The wrapper would look like:

1 prtctl(PR_SET_KEEPCAPS, 1)
2 setreuid(uid,uid)  
3 setregid(gid,gid)
4 desired_caps = cap_from_text(argv[caps])
5 capsetp(0,desired_caps)
6 execvp(argv[legacyapp])

This wrapper[1] (that would increase security) won't work with the current 
kernel though, because at step 6, all capabilities are cleared.

It looks like when a non uid 0 process execs, all capabilities are 
cleared.

The wrapper could also support chroot and setrlimit.

Dax Kelson
Guru Labs

[1] Marc Heuse wrote "compartment" that does caps OR set*uid, but not both 
(see my discussion above)

