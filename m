Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284573AbRLPKoO>; Sun, 16 Dec 2001 05:44:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284584AbRLPKoE>; Sun, 16 Dec 2001 05:44:04 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:40544 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S284573AbRLPKny>; Sun, 16 Dec 2001 05:43:54 -0500
Date: Sun, 16 Dec 2001 12:43:28 +0200
From: Ville Herva <vherva@niksula.hut.fi>
To: andrea@suse.com
Cc: linux-kernel@vger.kernel.org
Subject: Allocating 1GB on a 2GB ia64 box trigger oom rambo
Message-ID: <20011216124328.E21566@niksula.cs.hut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On an ia64 box with 2GB memory, 2.4.16+ia64-patch, the OOM rambo is too
hungry for blood:

./memstream2 512                  
testing mem stream, block size 536870912...

zsh: killed     ./memstream2 512

dmesg: Out of Memory: Killed process 28142 (memstream2).


vherva@whale:/home/vherva/scratch>free            
             total       used       free     shared    buffers     cached
Mem:       2057888    1353744     704144          0      63904    1100480
-/+ buffers/cache:     189360    1868528
Swap:       255984     166528      89456

vherva@whale:/home/vherva/scratch>cat /proc/slabinfo 
slabinfo - version: 1.1 (SMP)
kmem_cache           111    111    432    3    3    1 :  124   62
ip_fib_hash           10    454     32    1    1    1 :  252  126
urb_priv               1    123    128    1    1    1 :  252  126
journal_head         255    354     88    2    2    1 :  252  126
revoke_table           2    816     16    1    1    1 :  252  126
revoke_record          0      0     64    0    0    1 :  252  126
clip_arp_cache         0      0    256    0    0    1 :  252  126
ip_mrt_cache           0      0    128    0    0    1 :  252  126
tcp_tw_bucket          0      0    128    0    0    1 :  252  126
tcp_bind_bucket       20    240     64    1    1    1 :  252  126
tcp_open_request       0      0    128    0    0    1 :  252  126
inet_peer_cache        1    123    128    1    1    1 :  252  126
ip_dst_cache          49    310    256    5    5    1 :  252  126
arp_cache              6    166    192    2    2    1 :  252  126
blkdev_requests      512    581    192    7    7    1 :  252  126
dnotify cache          0      0     40    0    0    1 :  252  126
file lock cache        2    198    160    2    2    1 :  252  126
fasync cache           1    582     24    1    1    1 :  252  126
uid_cache              2    240     64    1    1    1 :  252  126
skbuff_head_cache    439    496    256    8    8    1 :  252  126
sock                 230    230   1600   23   23    1 :   60   30
sigqueue             222    348    136    3    3    1 :  252  126
cdev_cache           276    720     64    3    3    1 :  252  126
bdev_cache             6    246    128    2    2    1 :  252  126
mnt_cache             18    246    128    2    2    1 :  252  126
inode_cache         1862   7623    768  363  363    1 :  124   62
dentry_cache        1084   7968    192   96   96    1 :  252  126
dquot                  0      0    192    0    0    1 :  252  126
filp                1941   1992    192   24   24    1 :  252  126
names_cache            8      8   4096    2    2    1 :   60   30
buffer_head       289081 360386    192 4339 4342    1 :  252  126
mm_struct            313    372    256    6    6    1 :  252  126
vm_area_struct      4391   4565    192   55   55    1 :  252  126
fs_cache             313    480     64    2    2    1 :  252  126
files_cache          133    133    832    7    7    1 :  124   62
signal_act           110    110   1600   11   11    1 :   60   30
size-131072(DMA)       0      0 131072    0    0    8 :    0    0
size-131072            0      0 131072    0    0    8 :    0    0
size-65536(DMA)        0      0  65536    0    0    4 :    0    0
size-65536             0      0  65536    0    0    4 :    0    0
size-32768(DMA)        0      0  32768    0    0    2 :    0    0
size-32768             3      3  32768    3    3    2 :    0    0
size-16384(DMA)        0      0  16384    0    0    1 :   60   30
size-16384             1      1  16384    1    1    1 :   60   30
size-8192(DMA)         0      0   8192    0    0    1 :   60   30
size-8192             38     68   8192   19   34    1 :   60   30
size-4096(DMA)         0      0   4096    0    0    1 :   60   30
size-4096            220    220   4096   55   55    1 :   60   30
size-2048(DMA)         0      0   2048    0    0    1 :   60   30
size-2048            232    232   2048   29   29    1 :   60   30
size-1024(DMA)         0      0   1024    0    0    1 :  124   62
size-1024            720    720   1024   48   48    1 :  124   62
size-512(DMA)          0      0    512    0    0    1 :  124   62
size-512             186    186    512    6    6    1 :  124   62
size-256(DMA)          0      0    256    0    0    1 :  252  126
size-256            2528   2604    256   42   42    1 :  252  126
size-128(DMA)          1    123    128    1    1    1 :  252  126
size-128             448    738    128    6    6    1 :  252  126
size-64(DMA)           7    240     64    1    1    1 :  252  126
size-64             2442   7200     64   30   30    1 :  252  126



vherva@whale:/home/vherva/scratch>cat memstream2.c
#include <stdlib.h>
#include <stdio.h>
#include <sys/types.h>
                     
#define KB (1024)
#define MB (1024 * KB)
#define GB (1024 * MB)

inline unsigned chksum(char* buffer, int len)
{
    int i;
    unsigned c = 0;
    unsigned* ptr;
 
    for (ptr = (unsigned*)buffer; ptr < (unsigned*)&buffer[len]; ptr++)
        c += *ptr;

    return c;
}

int main(int argc, char** argv)
{
    unsigned long blocksz = 64*MB;
    unsigned long long streamed = 0, last = 0;
    unsigned iter = 0;
    unsigned checksum, orig_checksum = 0;
    const unsigned long long qgiga = 1024 * 1024 * 1024 / 4;
    time_t t = time(NULL);
    
    char *buffer1, *buffer2;
    int i;

    if (argc > 1) blocksz = atoi(argv[1]) * MB;

    fprintf(stderr, "testing mem stream, block size %u...\n\n          ", blocksz);

    buffer1 = malloc(blocksz + 256);
    buffer2 = malloc(blocksz + 256);
    if (!buffer1 || !buffer2) 
    {
        perror("malloc failed");
        exit(1);
    }
    for (i = 0; i < blocksz; i++)
        buffer1[i] = (i + rand()) % 256;

    orig_checksum = chksum(buffer1, blocksz);
    memcpy(buffer2, buffer1, blocksz);

    while (1)
    {
        int times = 8;
        unsigned checksum1, checksum2;
        for (i = 0; i < times; i++)
        {
           checksum1 = chksum(buffer1, blocksz);
           checksum2 = chksum(buffer2, blocksz);

           if (orig_checksum != checksum2 || checksum1 != checksum2)
           {
              fprintf(stderr, "Blocks differ! %x, %x\n", checksum, orig_checksum);           
              fprintf(stderr, "Read the blocks %i time (streamed %llu bytes.)\n", (iter * times + i * 2), streamed + blocksz * i * 2);
              exit(-1);
           }
        }

        streamed += blocksz * times * 2;

        if (streamed - last > qgiga) 
        { 
            
            fprintf(stderr, "\010\010\010\010\010\010\010\010\010\010.%6.1fMB/s", 
                    (float)(streamed - last) / (float)(time(NULL) - t) / (float)MB);
            t = time(NULL);
            last = streamed;
        }

        iter++;
    }

    return 0;
}


I tried to reproduce with a simpler program:

#include <stdio.h>
#include <stdlib.h>

#define BKSP "\010\010\010\010\010\010"

int main(int argc, char** argv)
{
    unsigned long megs = 512;
    unsigned long size, i;
    unsigned char* buf;
    if (argc > 1) megs = atol(argv[1]);
    size = megs * 1024 * 1024;
    
    fprintf(stderr, "Allocating %lu megs...\n\n      ", megs);
    buf = malloc(size);
    
    for (i = 0; i < size; i++)
    {
         buf[i] = 42;
         
         if ((i + 1) % (1024 * 1024) == 0) 
             fprintf(stderr, BKSP "%4uMB", (i + 1) / 1024 / 1024);
    }
    
    fprintf(stderr, "\n Success.\n");
    
    return 1;
}

I didn't get killed even with 1536 yet, but it basically halts at 1200+
megs:

./alloc 1536
Allocating 1536 megs...

1263MB
<hangs there making very little progress>

free
             total       used       free     shared    buffers     cached
Mem:       2057888    2051280       6608          0      63280     665296
-/+ buffers/cache:    1322704     735184
Swap:       255984     255984          0

>From top (after ten minutes):
    5 root      12   0     0    0     0 SW   88.9  0.0   5:29 kswapd
28312 vherva    20   0 1385M 1.3G   784 R    88.2 16.0   4:21 alloc


So again, releaseing cache seems to be the culprit.

I can try -aa if you think it's worth it.

 
-- v --

v@iki.fi
