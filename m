Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269958AbTHJP5E (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 11:57:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269978AbTHJP5D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 11:57:03 -0400
Received: from tomts25-srv.bellnexxia.net ([209.226.175.188]:46231 "EHLO
	tomts25-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S269958AbTHJP5A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 11:57:00 -0400
Subject: 2.6.0-test3-mm1 interactivity feedback and script
From: Shane Shrybman <shrybman@sympatico.ca>
To: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1060531015.7233.12.camel@mars.goatskin.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 10 Aug 2003 11:56:56 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I took WLI's suggestion and put together a little script that attempts
to gather some pertinent stats, (profile, vmstat, top), regarding
interactivity of the system.

I did a quick run that consists of refreshing a fat web page in mozilla
while playing a movie with mplayer. The movie still stutters slightly
during this test.

The results of the ten second run are here:

http://zeke.yi.org/linux/2.6.0-test3-mm1-prof/

And the script used was this:

#!/bin/sh

# Linux interactivity profiler script
# requires profile=2 (or 1?) as a kernel boot param
# Script takes optional number of iterations
# param., default is 10 iterations

# reset the profiler
readprofile -r

KERN=$(uname -r)
OUT_DIR=/root/profs

[ -w ${OUT_DIR} ] || OUT_DIR=$(pwd)

if [ -z $1 ]; then
        ITS=10
else
        ITS=$1
fi

# Collect vmstat output
vmstat 1 ${ITS}|cat -n > ${OUT_DIR}/${KERN}-vmstat &

# Collect top output
top b d1 n${ITS} > ${OUT_DIR}/${KERN}-top &

n=1
# Collect profile
while [ ${n} -le ${ITS} ]; do

        readprofile -n -m /boot/System.map-${KERN} \
        | sort -nr -k 3,3 > ${OUT_DIR}/${KERN}-prof.${n}

        n=$(( ${n} + 1 ))

        sleep 1
done

And is available here:

http://zeke.yi.org/linux/prof3

Regards,

Shane

